require 'spec_helper'

RSpec.describe Adyen::Recurring::ScheduleAccountUpdaterRequest, type: :model do
  it_behaves_like 'a Model with factory', :schedule_account_updater_request,
                  %i[reference shopper_reference selected_recurring_detail_reference]
  it_behaves_like 'a Model with required properties', :schedule_account_updater_request,
                  %i[reference shopper_reference selected_recurring_detail_reference]

  describe 'set_merchant_account' do
    subject { build :schedule_account_updater_request, merchant_account: nil }
    before  { subject.validate }

    it 'should set the value' do
      expect(subject.merchant_account).to eq('YOUR_MERCHANT_ACCOUNT_FOR_GERMANY')
    end
  end
end
