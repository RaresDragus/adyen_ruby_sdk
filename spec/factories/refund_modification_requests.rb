FactoryBot.define do
  factory :refund_modification_request, class: Adyen::Payments::RefundModificationRequest do
    original_reference  { 'copy pspreference from authorise' }
    reference           { 'payment-2017-8-18-16-capture' }
    modification_amount { build(:amount).to_h(for_hpp: false) }
  end
end
