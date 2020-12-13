require 'spec_helper'

RSpec.describe Adyen::Payments::VoidPendingRefundModificationRequest, type: :model do
  it_behaves_like 'a Model with factory', :void_pending_refund_modification_request,
                  %i[tender_reference unique_terminal_id]
  it_behaves_like 'a Model with required properties', :void_pending_refund_modification_request,
                  %i[tender_reference unique_terminal_id]

  describe 'set_merchant_account' do
    subject { build :void_pending_refund_modification_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
