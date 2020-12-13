FactoryBot.define do
  factory :recurring_details_result, class: Adyen::Recurring::RecurringDetailsResult do
    creation_date     { DateTime.now }
    details           { 2.times { build(:recurring_detail) } }
    shopper_reference { SecureRandom.hex }
  end
end
