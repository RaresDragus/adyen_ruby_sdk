FactoryBot.define do
  factory :payment_request_3ds2, class: Adyen::Payments::PaymentRequest3ds2 do
    browser_info   { FactoryBot.build(:browser_info).to_h(for_hpp: false) }
    mcc            { SecureRandom.uuid }
    threeds2_token { SecureRandom.hex }
    shopper_IP     { '64.34.23.12' }
  end
end
