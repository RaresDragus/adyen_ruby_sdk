FactoryBot.define do
  factory :recurring_detail, class: Adyen::Recurring::RecurringDetail do
    card_number_alias          { "Alias#{SecureRandom.hex}" }
    alias_type                 { "AliasType#{SecureRandom.hex}" }
    creation_date              { DateTime.now }
    first_psp_reference        { SecureRandom.hex }
    recurring_detail_reference { SecureRandom.hex }
    variant                    { 'visa' }
  end
end
