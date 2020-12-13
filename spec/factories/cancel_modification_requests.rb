FactoryBot.define do
  factory :cancel_modification_request, class: Adyen::Payments::CancelModificationRequest do
    original_reference  { 'copy pspreference from authorise' }
    reference           { 'payment-2017-8-18-16-capture' }
  end
end
