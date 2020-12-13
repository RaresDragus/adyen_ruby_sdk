FactoryBot.define do
  factory :recurring, class: Adyen::Payments::Recurring do
    contract { %w[ONECLICK RECURRING RECURRING,ONECLICK].sample }
  end
end
