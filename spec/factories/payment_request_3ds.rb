FactoryBot.define do
  factory :payment_request3d, class: Adyen::Payments::PaymentRequest3d do
    browser_info { FactoryBot.build(:browser_info).to_h(for_hpp: false) }
    md           { SecureRandom.uuid }
    pa_response  { SecureRandom.uuid }
    shopper_IP   { '64.34.23.12' }
  end
end
