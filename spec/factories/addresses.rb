FactoryBot.define do
  factory :address, class: Adyen::Common::Address do
    city                 { "City#{SecureRandom.hex}" }
    country              { 'DE' }
    street               { "Street #{SecureRandom.hex}" }
    house_number_or_name { rand(20).to_s }
    postal_code          { (0..rand(5..9)).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    state_or_province    { 'STA' }
  end
end
