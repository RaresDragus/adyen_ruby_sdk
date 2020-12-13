FactoryBot.define do
  factory :store_detail_response, class: Adyen::Payouts::StoreDetailResponse do
    psp_reference              { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    recurring_detail_reference { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    result_code                { 'Success' }
  end
end
