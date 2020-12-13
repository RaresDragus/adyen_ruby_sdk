FactoryBot.define do
  factory :store_detail_request, class: Adyen::Payouts::StoreDetailRequest do
    recurring         { build(:recurring, contract: 'PAYOUT') }
    bank              { build(:bank_account).to_h(for_hpp: false) }
    shopper_email     { 's.hopper@email.com' }
    shopper_reference { 'TheShopperReference' }
    shopper_name      { build(:name).to_h(for_hpp: false) }
    date_of_birth     { '1990-01-01' }
    entity_type       { 'NaturalPerson' }
    nationality       { 'NL' }
    billing_address   { build(:address).to_h(for_hpp: false) }
  end
end
