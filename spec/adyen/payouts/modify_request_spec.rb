require 'spec_helper'

RSpec.describe Adyen::Payouts::ModifyRequest, type: :model do
  it_behaves_like 'a Model with factory', :modify_request, %i[original_reference]
  it_behaves_like 'a Model with required properties', :modify_request, %i[original_reference]

  describe 'set_merchant_account' do
    subject { build :modify_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
