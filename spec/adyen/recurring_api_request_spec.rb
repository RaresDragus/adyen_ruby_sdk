require 'spec_helper'

RSpec.describe Adyen::RecurringApiRequest do
  let(:amount)    { build(:amount, value: 0).to_h(for_hpp: false) }
  let(:recurring) { build(:recurring, contract: 'RECURRING').to_h(for_hpp: false) }
  let(:payment_request) do
    build :payment_request,
          recurring:                  recurring,
          recurring_processing_model: 'CardOnFile',
          amount:                     amount,
          shopper_reference:          'adyen_ruby_sdk@example.com'
  end
  let(:recurring_details_request) do
    build :recurring_details_request, shopper_reference: payment_request.shopper_reference,
                                      recurring:         payment_request.recurring
  end
  let(:disable_request) do
    build :disable_request, contract: 'RECURRING', shopper_reference: payment_request.shopper_reference
  end

  describe 'list_recurring_details' do
    it 'should return a Adyen::Recurring::RecurringDetailsResult' do
      result = Adyen::PaymentApiRequest.authorise(payment_request, :de)

      expect(result).to be_a(Adyen::Payments::PaymentResult)
      expect(result.result_code).to eq('Authorised')

      result = described_class.list_recurring_details(recurring_details_request, :de)

      expect(result).to be_a(Adyen::Recurring::RecurringDetailsResult)
      disable_request.recurring_detail_reference = result.recurring_details.first.recurring_detail_reference
      described_class.disable(disable_request, :de)
    end
  end

  describe 'disable' do
    it 'should return a Adyen::Recurring::DisableResult' do
      result = Adyen::PaymentApiRequest.authorise(payment_request, :de)

      expect(result).to be_a(Adyen::Payments::PaymentResult)
      expect(result.result_code).to eq('Authorised')

      result = described_class.list_recurring_details(recurring_details_request, :de)

      expect(result).to be_a(Adyen::Recurring::RecurringDetailsResult)

      disable_request.recurring_detail_reference = result.recurring_details.first.recurring_detail_reference
      result = described_class.disable(disable_request, :de)

      expect(result).to be_a(Adyen::Recurring::DisableResult)
      expect(result.response).to eq('[detail-successfully-disabled]')
    end
  end
end
