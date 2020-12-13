FactoryBot.define do
  factory :void_pending_refund_modification_request, class: Adyen::Payments::VoidPendingRefundModificationRequest do
    tender_reference   { "Reference #{SecureRandom.hex}" }
    unique_terminal_id { SecureRandom.hex }
  end
end
