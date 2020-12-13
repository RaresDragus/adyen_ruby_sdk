FactoryBot.define do
  factory :modify_request, class: Adyen::Payouts::ModifyRequest do
    original_reference { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
  end
end
