FactoryBot.define do
  factory :submit_response, class: Adyen::Payouts::SubmitResponse do
    psp_reference  { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    refusal_reason { 'None' }
    result_code    { 'payout-submit-received' }
  end
end
