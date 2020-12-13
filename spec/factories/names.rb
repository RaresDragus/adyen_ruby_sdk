FactoryBot.define do
  factory :name, class: Adyen::Common::Name do
    first_name { 'FirstName' }
    last_name  { 'LastName' }
    gender     { %w[MALE FEMALE UNKNOWN].sample }
    infix      { 'Van der' }
  end
end
