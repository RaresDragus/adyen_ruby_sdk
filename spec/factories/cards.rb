FactoryBot.define do
  factory :card, class: Adyen::Payments::Card do
    cvc          { '737' }
    expiry_month { '10' }
    expiry_year  { '2020' }
    holder_name  { 'John Doe' }
    number       { '4111111111111111' }
  end
end
