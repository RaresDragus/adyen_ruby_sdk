FactoryBot.define do
  factory :amount, class: Adyen::Common::Amount do
    currency { 'EUR' }
    value    { 200 }
  end
end
