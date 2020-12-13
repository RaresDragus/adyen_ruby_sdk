FactoryBot.define do
  factory :submit_request, class: Adyen::Payouts::SubmitRequest do
    amount                              { build(:amount).to_h(for_hpp: false) }
    recurring                           { build(:recurring, contract: 'PAYOUT') }
    reference                           { 'TheMerchantReference' }
    selected_recurring_detail_reference { 'TheRecurringReference' }
    shopper_email                       { 's.hopper@email.com' }
    shopper_reference                   { 'TheShopperReference' }
    shopper_name                        { build(:name).to_h(for_hpp: false) }
    date_of_birth                       { '1990-01-01' }
    entity_type                         { 'NaturalPerson' }
    nationality                         { 'NL' }
  end
end
