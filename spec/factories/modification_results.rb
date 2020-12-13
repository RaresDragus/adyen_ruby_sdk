FactoryBot.define do
  factory :modification_result, class: Adyen::Payments::ModificationResult do
    psp_reference { (1..16).map { 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.chars.sample }.join }
    response      { '[capture-received]' }
  end
end
