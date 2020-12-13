require 'spec_helper'

RSpec.describe Adyen::Payments::PaymentRequest3ds2, type: :model do
  it_behaves_like 'a Model with factory', :payment_request_3ds2, %i[browser_info mcc shopper_IP threeds2_token]
  it_behaves_like 'a Model with required properties', :payment_request_3ds2, %i[threeds2_token]
  it_behaves_like 'a Model with maximum length validation', :payment_request_3ds2, :reference, 80
  it_behaves_like 'a Model with inclusion validation', :payment_request_3ds2, :shopper_interaction,
                  %w[Ecommerce ContAuth POS Moto]

  describe 'set_merchant_account' do
    subject { build :payment_request_3ds2, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
