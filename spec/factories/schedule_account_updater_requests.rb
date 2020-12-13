FactoryBot.define do
  factory :schedule_account_updater_request, class: Adyen::Recurring::ScheduleAccountUpdaterRequest do
    shopper_reference                   { SecureRandom.uuid }
    reference                           { SecureRandom.uuid }
    selected_recurring_detail_reference { SecureRandom.uuid }
  end
end
