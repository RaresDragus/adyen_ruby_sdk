# Namespace module for gem
module Adyen
  # Payment Api Requests
  class PaymentApiRequest < ApiRequest
    class << self
      [
        {
          method_name:   :authorise,
          request_class: 'Adyen::Payments::PaymentRequest',
          result_class:  'Adyen::Payments::PaymentResult'
        },
        {
          method_name:   :authorise3d,
          request_class: 'Adyen::Payments::PaymentRequest3d',
          result_class:  'Adyen::Payments::PaymentResult'
        },
        {
          method_name:   :authorise3ds2,
          request_class: 'Adyen::Payments::PaymentRequest3ds2',
          result_class:  'Adyen::Payments::PaymentResult3ds2'
        },
        {
          method_name:   :capture,
          request_class: 'Adyen::Payments::CaptureModificationRequest',
          result_class:  'Adyen::Payments::ModificationResult'
        },
        {
          method_name:   :cancel,
          request_class: 'Adyen::Payments::CancelModificationRequest',
          result_class:  'Adyen::Payments::ModificationResult'
        },
        {
          method_name:   :refund,
          request_class: 'Adyen::Payments::RefundModificationRequest',
          result_class:  'Adyen::Payments::ModificationResult'
        },
        {
          method_name:   :cancel_or_refund,
          request_class: 'Adyen::Payments::CancelOrRefundModificationRequest',
          result_class:  'Adyen::Payments::ModificationResult'
        },
        {
          method_name:   :void_pending_refund,
          request_class: 'Adyen::Payments::VoidPendingRefundModificationRequest',
          result_class:  'Adyen::Payments::ModificationResult'
        }
      ].each do |method|
        define_method(method[:method_name]) do |params, country|
          relative_url(method[:method_name])
          execute_json_request(method[:result_class], method[:request_class].constantize.req_params(params, country))
        end
      end
    end
  end
end
