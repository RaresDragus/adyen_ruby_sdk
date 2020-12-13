FactoryBot.define do
  factory :recurring_details_request, class: Adyen::Recurring::RecurringDetailsRequest do
    recurring         { build(:recurring).to_h(for_hpp: false) }
    shopper_reference { SecureRandom.hex }
  end
end
