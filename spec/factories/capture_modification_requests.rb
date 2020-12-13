FactoryBot.define do
  factory :capture_modification_request, class: Adyen::Payments::CaptureModificationRequest do
    original_reference  { 'copy pspreference from authorise' }
    reference           { 'payment-2017-8-18-16-capture' }
    modification_amount { build(:amount).to_h(for_hpp: false) }
  end
end
