require 'spec_helper'

RSpec.describe Adyen::Recurring::ScheduleAccountUpdaterResult, type: :model do
  it_behaves_like 'a Model with factory', :schedule_account_updater_result, %i[result psp_reference]
  it_behaves_like 'a Model with required properties', :schedule_account_updater_result, %i[result psp_reference]
end
