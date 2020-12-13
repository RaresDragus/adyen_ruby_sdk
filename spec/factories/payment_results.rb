FactoryBot.define do
  factory :payment_result, class: Adyen::Payments::PaymentResult do
    auth_code     { SecureRandom.hex }
    psp_reference { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    result_code   { %w[Authorized Refused Error Cancelled Received RedirectShopper].sample }
  end
end
