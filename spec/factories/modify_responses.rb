FactoryBot.define do
  factory :modify_response, class: Adyen::Payouts::ModifyResponse do
    psp_reference { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    response      { %w[payout-confirm-received payout-decline-received].sample }
  end
end
