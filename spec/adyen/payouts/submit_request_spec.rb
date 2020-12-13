require 'spec_helper'

RSpec.describe Adyen::Payouts::SubmitRequest, type: :model do
  it_behaves_like 'a Model with factory', :submit_request,
                  %i[amount recurring reference shopper_email shopper_reference shopper_name date_of_birth
                     entity_type nationality selected_recurring_detail_reference]
  it_behaves_like 'a Model with required properties', :submit_request,
                  %i[amount recurring reference shopper_email shopper_reference
                     entity_type nationality selected_recurring_detail_reference]
  it_behaves_like 'a Model with fixed length validation', :submit_request, :nationality, 2
  it_behaves_like 'a Model with inclusion validation', :submit_request, :entity_type,
                  %w[NaturalPerson Company]

  describe 'set_merchant_account' do
    subject { build :submit_request, merchant_account: nil }

    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
