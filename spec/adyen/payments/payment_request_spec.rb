require 'spec_helper'

RSpec.describe Adyen::Payments::PaymentRequest, type: :model do
  it_behaves_like 'a Model with factory', :payment_request, %i[amount reference additional_data]
  it_behaves_like 'a Model with required properties', :payment_request, %i[amount reference]
  it_behaves_like 'a Model with maximum length validation', :payment_request, :reference, 80
  it_behaves_like 'a Model with inclusion validation', :payment_request, :shopper_interaction,
                  %w[Ecommerce ContAuth POS Moto]

  describe 'set_merchant_account' do
    subject { build :payment_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
