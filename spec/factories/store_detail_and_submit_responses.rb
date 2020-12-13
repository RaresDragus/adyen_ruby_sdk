FactoryBot.define do
  factory :store_detail_and_submit_response, class: Adyen::Payouts::StoreDetailAndSubmitResponse do
    psp_reference { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    result_code   { 'payout-submit-received' }
  end
end
