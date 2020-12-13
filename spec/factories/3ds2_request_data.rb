FactoryBot.define do
  factory :threeds2_request_data, class: Adyen::Payments::ThreeDS2RequestData do
    device_channel   { 'browser' }
    notification_URL { 'https://example.com/checkout' }
  end
end
