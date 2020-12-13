FactoryBot.define do
  factory :forex_quote, class: Adyen::Payments::ForexQuote do
    base_points { rand(20) }
    valid_till  { DateTime.now }
  end
end
