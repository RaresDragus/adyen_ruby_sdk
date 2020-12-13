require 'spec_helper'

RSpec.describe Adyen::Recurring::DisableRequest, type: :model do
  it_behaves_like 'a Model with factory', :disable_request, %i[contract recurring_detail_reference shopper_reference]
  it_behaves_like 'a Model with required properties', :disable_request, %i[shopper_reference]

  describe 'set_merchant_account' do
    subject { build :disable_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
