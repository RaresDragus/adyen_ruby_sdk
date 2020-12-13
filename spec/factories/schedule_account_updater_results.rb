FactoryBot.define do
  factory :schedule_account_updater_result, class: Adyen::Recurring::ScheduleAccountUpdaterResult do
    result        { 'success' }
    psp_reference { SecureRandom.uuid }
  end
end
