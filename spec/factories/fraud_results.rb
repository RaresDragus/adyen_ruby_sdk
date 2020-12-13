FactoryBot.define do
  factory :fraud_result, class: Adyen::Payments::FraudResult do
    account_score { rand(20) }
  end
end
