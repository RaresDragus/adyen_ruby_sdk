FactoryBot.define do
  factory :promotion, class: Adyen::Common::Promotion do
    promotion_code              { 'PROMOCODE1234' }
    promotion_name              { 'Promo Code 1234' }
    promotion_discount_amount   { '5' }
    promotion_discount_currency { 'EUR' }
  end
end
