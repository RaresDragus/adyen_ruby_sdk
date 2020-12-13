FactoryBot.define do
  factory :bank_account, class: Adyen::Payments::BankAccount do
    bank_account_number { '1005000' }
    bank_city           { "City#{SecureRandom.hex}" }
    bank_location_id    { rand(20).to_s }
    bank_name           { 'AbnAmro' }
    bic                 { 'ABNANL2A' }
    country_code        { 'NL' }
    iban                { 'NL32ABNA0515071439' }
    owner_name          { 'Owner Name' }
    tax_id              { 'bankTaxId' }
  end
end
