FactoryBot.define do
  factory :fraud_check_result, class: Adyen::Payments::FraudCheckResult do
    account_score { rand(20) }
    check_id      { rand(20) }
    name          { "Name#{SecureRandom.hex}" }
  end
end
