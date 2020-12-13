FactoryBot.define do
  factory :store_detail_and_submit_request, class: Adyen::Payouts::StoreDetailAndSubmitRequest do
    amount            { build(:amount).to_h(for_hpp: false) }
    recurring         { build(:recurring, contract: 'PAYOUT') }
    bank              { build(:bank_account).to_h(for_hpp: false) }
    reference         { 'TheMerchantReference' }
    shopper_email     { 's.hopper@email.com' }
    shopper_reference { 'TheShopperReference' }
    shopper_name      { build(:name).to_h(for_hpp: false) }
    date_of_birth     { '1990-01-01' }
    entity_type       { 'NaturalPerson' }
    nationality       { 'DE' }
    billing_address   { build(:address).to_h(for_hpp: false) }
  end
end
