FactoryBot.define do
  factory :payment_result_3ds2, class: Adyen::Payments::PaymentResult3ds2 do
    auth_code     { SecureRandom.hex }
    psp_reference { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    result_code   { %w[Authorized Refused Error Cancelled Received RedirectShopper].sample }
  end
end
