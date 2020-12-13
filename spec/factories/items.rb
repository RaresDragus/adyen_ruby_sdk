FactoryBot.define do
  factory :item, class: Adyen::Common::Item do
    item_ID         { SecureRandom.uuid }
    product_title   { "Product#{SecureRandom.hex}" }
    amount_per_item { rand(50).to_s }
    currency        { 'EUR' }
    upc             { SecureRandom.uuid }
    sku             { SecureRandom.uuid }
    brand           { "Brand#{SecureRandom.hex}" }
    manufacturer    { "Manufacturer#{SecureRandom.hex}" }
    category        { "Category#{SecureRandom.hex}" }
    color           { "Color#{SecureRandom.hex}" }
    size            { rand(27..50).to_s }
    quantity        { rand(1..5).to_s }
  end
end
