FactoryBot.define do
  factory :hpp_payment_request, class: Adyen::Hpp::PaymentRequest do
    payment_amount       { rand(20) * 1000 }
    merchant_reference   { SecureRandom.uuid }
    currency_code        { 'EUR' }
    ship_before_date     { (Date.today + 30).strftime('%Y-%m-%d') }
    session_validity     { '2017-10-29T17:12:37Z' }
    shopper_locale       { 'de_DE' }
    country_code         { 'DE' }
    shopper_email        { 'contact-buyer@example.com' }
    shopper_reference    { 'contact-buyer@example.com' }
    brand_code           { 'paypal' }
    offset               { 0 }
    billing_address      { build(:address).to_h(for_hpp: true) }
  end
end
