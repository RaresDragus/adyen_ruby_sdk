require 'spec_helper'

RSpec.describe Adyen::Payouts::StoreDetailAndSubmitRequest, type: :model do
  it_behaves_like 'a Model with factory', :store_detail_and_submit_request,
                  %i[amount recurring bank reference shopper_email shopper_reference shopper_name date_of_birth
                     entity_type nationality billing_address]
  it_behaves_like 'a Model with required properties', :store_detail_and_submit_request,
                  %i[amount recurring reference shopper_email shopper_reference shopper_name
                     entity_type nationality]
  it_behaves_like 'a Model with fixed length validation', :store_detail_and_submit_request, :nationality, 2
  it_behaves_like 'a Model with inclusion validation', :store_detail_and_submit_request, :entity_type,
                  %w[NaturalPerson Company]

  describe 'set_merchant_account' do
    subject { build :store_detail_and_submit_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
