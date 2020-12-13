FactoryBot.define do
  factory :installments, class: Adyen::Common::Installments do
    value { 2 }
  end
end
