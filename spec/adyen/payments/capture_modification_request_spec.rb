require 'spec_helper'

RSpec.describe Adyen::Payments::CaptureModificationRequest, type: :model do
  it_behaves_like 'a Model with factory', :capture_modification_request,
                  %i[modification_amount original_reference reference]
  it_behaves_like 'a Model with required properties', :capture_modification_request,
                  %i[modification_amount original_reference]
  it_behaves_like 'a Model with maximum length validation', :capture_modification_request, :reference, 80

  describe 'set_merchant_account' do
    subject { build :capture_modification_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
