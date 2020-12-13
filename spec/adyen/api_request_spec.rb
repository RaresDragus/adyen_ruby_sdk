require 'spec_helper'

RSpec.describe Adyen::ApiRequest do
  context 'protected methods' do
    describe 'relative_url' do
      it 'should return a camelize version of the method_name' do
        expect(described_class.send(:relative_url, :skip_details)).to eq('skipDetails')
      end
    end

    describe 'class_name_to_sym' do
      it 'should return a custom symbol based on class name' do
        expect(described_class.send(:class_name_to_sym)).to eq(:api)
      end
    end

    describe 'execute_json_request' do
      let(:error_result) { build :service_exception }
      let(:req_params)   { build :payment_request }

      context 'when the result is an Adyen::Common::ServiceException' do
        before do
          allow(Adyen::Connection).to receive(:send_json_request) { error_result }
        end

        it 'should return an Adyen::Common::ServiceException' do
          expect(
            described_class.send(:execute_json_request, 'Adyen::Payments::PaymentResult', req_params)
          ).to eq(error_result)
        end
      end

      context 'when the result is a Hash which includes error information' do
        before do
          allow(Adyen::Connection).to receive(:send_json_request) { error_result.to_h(for_hpp: false) }
        end

        it 'should return an Adyen::Common::ServiceException' do
          expect(
            described_class.send(:execute_json_request, 'Adyen::Payments::PaymentResult', req_params)
          ).to be_a(Adyen::Common::ServiceException)
        end
      end

      context 'when the result is a Hash which includes relevant data' do
        before do
          allow(Adyen::Connection).to receive(:send_json_request) { req_params.to_h(for_hpp: false) }
        end

        it 'should return an Adyen::Payments::PaymentResult' do
          expect(
            described_class.send(:execute_json_request, 'Adyen::Payments::PaymentResult', req_params)
          ).to be_a(Adyen::Payments::PaymentResult)
        end
      end
    end
  end
end
