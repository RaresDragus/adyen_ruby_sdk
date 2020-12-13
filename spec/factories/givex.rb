FactoryBot.define do
  factory :givex, class: Adyen::Payments::Givex do
    expiry_month { '08' }
    expiry_year  { '2018' }
    holder_name  { 'Holder Name' }
    number       { (4..19).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
  end
end
