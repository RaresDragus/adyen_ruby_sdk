FactoryBot.define do
  factory :payment_request, class: Adyen::Payments::PaymentRequest do
    amount                { build(:amount).to_h(for_hpp: false) }
    reference             { 'Reference' }
    additional_data       { build(:card).encode }
    billing_address       { build(:address).to_h(for_hpp: false) }
    browser_info          { build(:browser_info).to_h(for_hpp: false) }
    shopper_IP            { '192.0.2.1' }
    threeds2_request_data { build(:threeds2_request_data).to_h(for_hpp: false) }
  end
end
