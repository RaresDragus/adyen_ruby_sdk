FactoryBot.define do
  factory :disable_request, class: Adyen::Recurring::DisableRequest do
    contract                   { %w[ONECLICK RECURRING PAYOUT'].sample }
    recurring_detail_reference { SecureRandom.hex }
    shopper_reference          { SecureRandom.hex }
  end
end
