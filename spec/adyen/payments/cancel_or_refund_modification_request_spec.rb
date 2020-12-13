require 'spec_helper'

RSpec.describe Adyen::Payments::CancelOrRefundModificationRequest, type: :model do
  it_behaves_like 'a Model with factory', :cancel_or_refund_modification_request, %i[original_reference reference]
  it_behaves_like 'a Model with required properties', :cancel_or_refund_modification_request, %i[original_reference]
  it_behaves_like 'a Model with maximum length validation', :cancel_or_refund_modification_request, :reference, 80

  describe 'set_merchant_account' do
    subject { build :cancel_or_refund_modification_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
