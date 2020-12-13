require 'spec_helper'

RSpec.describe Adyen::PaymentApiRequest do
  context 'for Germany' do
    describe 'authorise' do
      let(:payment_request) { build :payment_request }
      let(:recurring_details_request) do
        build :recurring_details_request, shopper_reference: payment_request.shopper_reference,
                                          recurring:         first_payment_request.recurring
      end

      it 'should return a Adyen::Payments::PaymentResult object with CSE Authorisation' do
        result = described_class.authorise(payment_request, :de)

        expect(result).to be_a(Adyen::Payments::PaymentResult)
        expect(result.result_code).to eq('Authorised')
      end

      it 'should return a Adyen::Common::ServiceException object without CSE Authorisation' do
        payment_request.additional_data = nil
        payment_request.card = build(:card).to_h(for_hpp: false)
        result = described_class.authorise(payment_request, :de)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(403)
        expect(result.error_code).to eq('010')
        expect(result.message).to eq('Not allowed')
        expect(result.error_type).to eq('security')
      end
    end

    describe 'authorise3d' do
      let(:payment_request3d) { build :payment_request3d }

      it 'should return a Adyen::Common::ServiceException object if already processed' do
        payment_request3d.md =
          '/8U5NgersRDiU5970QI/dDkujFILflcmxM4SMRIsp93ygZJYDR86fITOiDPMZgEluYdZxF+w0LyR+tyBYyKR1tAJ'\
          'y+Y+wZfAQLbyfMCuelKaaBq+4V49CWs7OFl+3c62K7/8iUjSuaUV6xXzc8PGhTYvHaRWLtsMWurL4tsPKepKTjyV'\
          'A5UPML7cFGVnuuSz0FeeeV8SX91nroBZbXr0voimxmwbMDL2xTzVanjMObzpPDI0P5S8FEYbW5+GVOYqQEyvue+C'\
          'BTKc/0lYcBWDIaFHudNd2RnuWADxbncctn3+9PbvMF4mtT/FT7WhOMWYCJD8LDTgV2TUiBsqJY3HjoE/umIvUCX1'\
          'lRxVS5zBdpU='
        payment_request3d.pa_response =
          'eNpVUsluwjAQ/RXaD4iXYLJosOSSSuXAIhoOPVWRM4JITQJOUpavrx1IaX3xvFmeZ94Y0r1BTN5RdwY'\
          'lLLBpsh2Oinz6HIehL+iEUl9M/Cjw6bOEtdrgUcI3mqaoK8k86nEgA7TlRu+zqpWQ6ePLfCkF4/4YyB'\
          '1BiWaeyBSbdl2WSh+7wqABcnNDlZUot+pTzZ5itZ4ntW4GQgakj4Kuu6o1Fyl4CGQA0JkvuW/bQ0zI6'\
          'XTysvyClafrEoiLAHn0te6c1Vimc5HLVbK7LlPFF4my98d1lerrQvVnCsRlQJ61KDllAY04G7FxzKKY'\
          '+0B6P2Sla0G+bjcjJjxK7ag3DxzcQ+oGmHCRvx6wchus9EVGgRtkQIDnQ12hzbCy/tpAHm3P3py4urW'\
          'CCe7UFZMgjOigcx9wLIXVhYU07GkcAOJKyX2D5L5pa/37AT8ni6yU'
        result = described_class.authorise3d(payment_request3d, :de)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.error_code).to eq('704')
        expect(result.message).to start_with('request already processed')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'cancel' do
      let(:payment_request)             { build :payment_request }
      let(:cancel_modification_request) { build :cancel_modification_request }

      it 'should return a Adyen::Payments::ModificationResult' do
        result = described_class.authorise(payment_request, :de)
        cancel_modification_request.original_reference = result.psp_reference
        result = described_class.cancel(cancel_modification_request, :de)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[cancel-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        result = described_class.cancel(cancel_modification_request, :de)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.error_code).to eq('167')
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'cancel_or_refund' do
      let(:payment_request)                       { build :payment_request }
      let(:cancel_or_refund_modification_request) { build :cancel_or_refund_modification_request }

      it 'should return a Adyen::Payments::ModificationResult' do
        result = described_class.authorise(payment_request, :de)
        cancel_or_refund_modification_request.original_reference = result.psp_reference
        result = described_class.cancel_or_refund(cancel_or_refund_modification_request, :de)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[cancelOrRefund-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        result = described_class.cancel_or_refund(cancel_or_refund_modification_request, :de)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.error_code).to eq('167')
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'capture' do
      let(:payment_request) { build :payment_request }
      let(:capture_modification_request) do
        build :capture_modification_request, modification_amount: payment_request.amount
      end

      it 'should return a Adyen::Payments::ModificationResult' do
        authorise_result = described_class.authorise(payment_request, :de)
        capture_modification_request.original_reference = authorise_result.psp_reference
        sleep 10
        result = described_class.capture(capture_modification_request, :de)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[capture-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        result = described_class.capture(capture_modification_request, :de)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'refund' do
      let(:payment_request) { build :payment_request }
      let(:capture_modification_request) do
        build :capture_modification_request, modification_amount: payment_request.amount
      end
      let(:refund_modification_request) do
        build :refund_modification_request, modification_amount: payment_request.amount
      end

      it 'should return a Adyen::Payments::ModificationResult' do
        result = described_class.authorise(payment_request, :de)
        capture_modification_request.original_reference = result.psp_reference
        result = described_class.capture(capture_modification_request, :de)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[capture-received]')

        refund_modification_request.original_reference = capture_modification_request.original_reference
        result = described_class.refund(refund_modification_request, :de)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[refund-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        capture = build(:capture_modification_request, modification_amount: payment_request.amount)
        result = described_class.capture(capture, :de)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end

    context 'After Payments' do
      let(:amount)    { build(:amount, value: 0).to_h(for_hpp: false) }
      let(:recurring) { build(:recurring, contract: 'RECURRING').to_h(for_hpp: false) }
      let(:name) do
        build(:name, first_name: 'AdyenRuby', last_name: 'SDK', gender: 'UNKNOWN').to_h(for_hpp: false)
      end
      let(:card) do
        build :card, cvc: '737', expiry_month: '08', expiry_year: '2018', holder_name: 'ADYENRUBY SDK',
                     number: '4111111111111111'
      end

      let(:billing_agreement) do
        build :payment_request,
              recurring:                  recurring,
              recurring_processing_model: 'CardOnFile',
              amount:                     amount,
              shopper_reference:          'adyen_ruby_sdk@example.com',
              shopper_email:              'adyen_ruby_sdk@example.com',
              shopper_locale:             'de_DE',
              shopper_name:               name,
              additional_data:            card.encode,
              reference:                  'adyen_ruby_sdk@example.com - CC1111',
              fraud_offset:               0
      end
      let(:recurring_details_request) do
        build :recurring_details_request, shopper_reference: billing_agreement.shopper_reference,
                                          recurring:         billing_agreement.recurring
      end
      let(:first_cc_payment_request) do
        build :payment_request,
              recurring:           billing_agreement.recurring,
              amount:              build(:amount, value: 3300).to_h(for_hpp: false),
              shopper_reference:   billing_agreement.shopper_reference,
              shopper_interaction: 'ContAuth',
              shopper_email:       billing_agreement.shopper_email,
              shopper_name:        billing_agreement.shopper_name,
              fraud_offset:        0
      end
      let(:second_cc_payment_request) do
        build :payment_request,
              recurring:           billing_agreement.recurring,
              amount:              build(:amount, value: 4400).to_h(for_hpp: false),
              shopper_reference:   billing_agreement.shopper_reference,
              shopper_interaction: 'ContAuth',
              shopper_email:       billing_agreement.shopper_email,
              shopper_name:        billing_agreement.shopper_name,
              fraud_offset:        0
      end
      let(:first_paypal_request) do
        build(
          :payment_request,
          shopper_reference:          'contact-buyer@example.com',
          shopper_email:              'contact-buyer@example.com',
          additional_data:            {},
          shopper_interaction:        'ContAuth',
          selected_brand:             'paypal',
          amount:                     build(:amount, value: 4500).to_h(for_hpp: false),
          recurring:                  build(:recurring, contract: 'RECURRING').to_h(for_hpp: false),
          recurring_processing_model: 'CardOnFile'
        )
      end

      xdescribe 'zero value request with PayPal' do
        it 'should be successful' do
          recurring_details_request.shopper_reference = 'contact-buyer@example.com'
          result = Adyen::RecurringApiRequest.list_recurring_details(recurring_details_request, :de)
          expect(result).to be_a(Adyen::Recurring::RecurringDetailsResult)
          first_paypal_request.selected_recurring_detail_reference =
            result.recurring_details.first.recurring_detail_reference
          result = Adyen::PaymentApiRequest.authorise(first_paypal_request, :de)
          expect(result).to be_a(Adyen::Payments::PaymentResult)
          expect(result.result_code).to eq('Authorised')
        end
      end

      describe 'user is canceling the PayPal subscription' do
        it 'should return the "refused" result code' do
          recurring_details_request.shopper_reference = 'paypalcanceling'
          result = Adyen::RecurringApiRequest.list_recurring_details(recurring_details_request, :de)
          expect(result).to be_a(Adyen::Recurring::RecurringDetailsResult)
          first_paypal_request.selected_recurring_detail_reference =
            result.recurring_details.first.recurring_detail_reference
          first_paypal_request.shopper_reference = 'paypalcanceling'
          first_paypal_request.shopper_email = 'contact-buyer@example.com'
          first_paypal_request.additional_data = ''
          first_paypal_request.shopper_interaction = 'ContAuth'
          first_paypal_request.selected_brand = 'paypal'
          result = Adyen::PaymentApiRequest.authorise(first_paypal_request, :de)
          expect(result).to be_a(Adyen::Payments::PaymentResult)
          expect(result.result_code).to eq('Refused')
          expect(result.refusal_reason).to eq('Refused')
        end
      end

      describe 'zero value request with credit card' do
        before { Adyen::PaymentApiRequest.authorise(billing_agreement, :de) }

        it 'should be successful' do
          sleep 5
          list_result = Adyen::RecurringApiRequest.list_recurring_details(recurring_details_request, :de)

          expect(list_result).to be_a(Adyen::Recurring::RecurringDetailsResult)

          first_cc_payment_request.selected_recurring_detail_reference =
            list_result.recurring_details.first.recurring_detail_reference
          result = Adyen::PaymentApiRequest.authorise(first_cc_payment_request, :de)

          expect(result).to be_a(Adyen::Payments::PaymentResult)
          expect(result.result_code).to eq('Authorised')

          second_cc_payment_request.selected_recurring_detail_reference =
            list_result.recurring_details.first.recurring_detail_reference
          result = Adyen::PaymentApiRequest.authorise(second_cc_payment_request, :de)

          expect(result).to be_a(Adyen::Payments::PaymentResult)
          expect(result.result_code).to eq('Authorised')
          Adyen::RecurringApiRequest.disable(
            build(
              :disable_request,
              shopper_reference:          billing_agreement.shopper_reference,
              contract:                   'RECURRING',
              recurring_detail_reference: list_result.recurring_details.first.recurring_detail_reference
            ), :de
          )
        end

        it 'should return a service exception if the billing agreement was disabled' do
          list_result = Adyen::RecurringApiRequest.list_recurring_details(recurring_details_request, :de)

          expect(list_result).to be_a(Adyen::Recurring::RecurringDetailsResult)
          Adyen::RecurringApiRequest.disable(
            build(
              :disable_request,
              shopper_reference:          billing_agreement.shopper_reference,
              contract:                   'RECURRING',
              recurring_detail_reference: list_result.recurring_details.first.recurring_detail_reference
            ), :de
          )
          first_cc_payment_request.selected_recurring_detail_reference =
            list_result.recurring_details.first.recurring_detail_reference
          result = Adyen::PaymentApiRequest.authorise(first_cc_payment_request, :de)
          expect(result).to be_a(Adyen::Common::ServiceException)
          expect(result.message).to eq('PaymentDetail not found')
        end
      end

      describe 'with expired credit card' do
        let(:ex_card) do
          build :card, cvc: '737', expiry_month: '08', expiry_year: '2017', holder_name: 'ADYENRUBY SDK',
                number: '5100081112223332'
        end

        let(:ex_billing_agreement) do
          build :payment_request,
                recurring:                  recurring,
                recurring_processing_model: 'CardOnFile',
                amount:                     amount,
                shopper_reference:          'adyen_ruby_sdk@example.com',
                shopper_email:              'adyen_ruby_sdk@example.com',
                shopper_locale:             'de_DE',
                shopper_name:               name,
                additional_data:            ex_card.encode,
                reference:                  'adyen_ruby_sdk@example.com - CC1111',
                fraud_offset:               0
        end

        it 'should return the proper message' do
          result = Adyen::PaymentApiRequest.authorise(ex_billing_agreement, :de)
          expect(result.result_code).to eq('Refused')
          expect(result.refusal_reason).to eq('Expired Card')
        end
      end
    end
  end

  context 'for Austria' do
    let(:payment_request) { build :payment_request }

    describe 'authorise' do
      let(:recurring_details_request) do
        build :recurring_details_request, shopper_reference: payment_request.shopper_reference,
                                          recurring:         first_payment_request.recurring
      end

      it 'should return a Adyen::Payments::PaymentResult object with CSE Authorisation' do
        result = described_class.authorise(payment_request, :at)

        expect(result).to be_a(Adyen::Payments::PaymentResult)
        expect(result.result_code).to eq('Authorised')
      end

      it 'should return a Adyen::Common::ServiceException object without CSE Authorisation' do
        payment_request.additional_data = nil
        payment_request.card = build(:card).to_h(for_hpp: false)
        result = described_class.authorise(payment_request, :at)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(403)
        expect(result.error_code).to eq('010')
        expect(result.message).to eq('Not allowed')
        expect(result.error_type).to eq('security')
      end
    end

    describe 'authorise3d' do
      let(:payment_request3d) { build :payment_request3d }

      it 'should return a Adyen::Common::ServiceException object if already processed' do
        payment_request3d.md =
          '/8U5NgersRDiU5970QI/dDkujFILflcmxM4SMRIsp93ygZJYDR86fITOiDPMZgEluYdZxF+w0LyR+tyBYyKR1tAJ'\
          'y+Y+wZfAQLbyfMCuelKaaBq+4V49CWs7OFl+3c62K7/8iUjSuaUV6xXzc8PGhTYvHaRWLtsMWurL4tsPKepKTjyV'\
          'A5UPML7cFGVnuuSz0FeeeV8SX91nroBZbXr0voimxmwbMDL2xTzVanjMObzpPDI0P5S8FEYbW5+GVOYqQEyvue+C'\
          'BTKc/0lYcBWDIaFHudNd2RnuWADxbncctn3+9PbvMF4mtT/FT7WhOMWYCJD8LDTgV2TUiBsqJY3HjoE/umIvUCX1'\
          'lRxVS5zBdpU='
        payment_request3d.pa_response =
          'eNpVUsluwjAQ/RXaD4iXYLJosOSSSuXAIhoOPVWRM4JITQJOUpavrx1IaX3xvFmeZ94Y0r1BTN5RdwY'\
          'lLLBpsh2Oinz6HIehL+iEUl9M/Cjw6bOEtdrgUcI3mqaoK8k86nEgA7TlRu+zqpWQ6ePLfCkF4/4YyB'\
          '1BiWaeyBSbdl2WSh+7wqABcnNDlZUot+pTzZ5itZ4ntW4GQgakj4Kuu6o1Fyl4CGQA0JkvuW/bQ0zI6'\
          'XTysvyClafrEoiLAHn0te6c1Vimc5HLVbK7LlPFF4my98d1lerrQvVnCsRlQJ61KDllAY04G7FxzKKY'\
          '+0B6P2Sla0G+bjcjJjxK7ag3DxzcQ+oGmHCRvx6wchus9EVGgRtkQIDnQ12hzbCy/tpAHm3P3py4urW'\
          'CCe7UFZMgjOigcx9wLIXVhYU07GkcAOJKyX2D5L5pa/37AT8ni6yU'
        result = described_class.authorise3d(payment_request3d, :at)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.error_code).to eq('704')
        expect(result.message).to start_with('request already processed')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'cancel' do
      let(:cancel_modification_request) { build :cancel_modification_request }

      it 'should return a Adyen::Payments::ModificationResult' do
        result = described_class.authorise(payment_request, :at)
        cancel_modification_request.original_reference = result.psp_reference
        result = described_class.cancel(cancel_modification_request, :at)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[cancel-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        result = described_class.cancel(cancel_modification_request, :at)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.error_code).to eq('167')
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'cancel_or_refund' do
      let(:cancel_or_refund_modification_request) { build :cancel_or_refund_modification_request }

      it 'should return a Adyen::Payments::ModificationResult' do
        result = described_class.authorise(payment_request, :at)
        cancel_or_refund_modification_request.original_reference = result.psp_reference
        result = described_class.cancel_or_refund(cancel_or_refund_modification_request, :at)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[cancelOrRefund-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        result = described_class.cancel_or_refund(cancel_or_refund_modification_request, :at)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.error_code).to eq('167')
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'capture' do
      let(:capture_modification_request) do
        build :capture_modification_request, modification_amount: payment_request.amount
      end

      it 'should return a Adyen::Payments::ModificationResult' do
        authorise_result = described_class.authorise(payment_request, :at)
        capture_modification_request.original_reference = authorise_result.psp_reference
        result = described_class.capture(capture_modification_request, :at)

        expect(result).to be_a(Adyen::Payments::ModificationResult)
        expect(result.response).to eq('[capture-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        result = described_class.capture(capture_modification_request, :at)

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end

    describe 'refund' do
      let(:capture_modification_request) do
        build :capture_modification_request, modification_amount: payment_request.amount
      end
      let(:refund_modification_request) do
        build :refund_modification_request, modification_amount: payment_request.amount
      end

      it 'should return a Adyen::Payments::ModificationResult' do
        authorise_result = described_class.authorise(payment_request, :at)
        capture_modification_request.original_reference = authorise_result.psp_reference
        capture_result = described_class.capture(capture_modification_request, :at)

        expect(capture_result).to be_a(Adyen::Payments::ModificationResult)
        expect(capture_result.response).to eq('[capture-received]')

        refund_modification_request.original_reference = capture_modification_request.original_reference
        refund_result = described_class.refund(refund_modification_request, :at)

        expect(refund_result).to be_a(Adyen::Payments::ModificationResult)
        expect(refund_result.response).to eq('[refund-received]')
      end

      it 'should return a Adyen::Common::ServiceException object if psp_reference is not valid' do
        result = described_class.capture(
          build(:capture_modification_request, modification_amount: payment_request.amount), :at
        )

        expect(result).to be_a(Adyen::Common::ServiceException)
        expect(result.status).to eq(422)
        expect(result.message).to eq('Original pspReference required for this operation')
        expect(result.error_type).to eq('validation')
      end
    end
  end
end
