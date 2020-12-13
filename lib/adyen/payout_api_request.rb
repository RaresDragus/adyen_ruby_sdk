# Namespace module for gem
module Adyen
  # Payout Api Requests
  class PayoutApiRequest < ApiRequest
    class << self
      [
        {
          method_name:   :store_detail_and_submit_third_party,
          request_class: 'Adyen::Payouts::StoreDetailAndSubmitRequest',
          result_class:  'Adyen::Payouts::StoreDetailAndSubmitResponse'
        },
        {
          method_name:   :submit_third_party,
          request_class: 'Adyen::Payouts::SubmitRequest',
          result_class:  'Adyen::Payouts::SubmitResponse'
        },
        {
          method_name:   :confirm_third_party,
          request_class: 'Adyen::Payouts::ModifyRequest',
          result_class:  'Adyen::Payouts::ModifyResponse'
        },
        {
          method_name:   :decline_third_party,
          request_class: 'Adyen::Payouts::ModifyRequest',
          result_class:  'Adyen::Payouts::ModifyResponse'
        },
        {
          method_name:   :store_detail,
          request_class: 'Adyen::Payouts::StoreDetailRequest',
          result_class:  'Adyen::Payouts::StoreDetailResponse'
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
