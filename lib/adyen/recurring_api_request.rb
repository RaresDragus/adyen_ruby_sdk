# Namespace module for gem
module Adyen
  # Recurring Api Requests
  class RecurringApiRequest < ApiRequest
    class << self
      [
        {
          method_name:   :disable,
          request_class: 'Adyen::Recurring::DisableRequest',
          result_class:  'Adyen::Recurring::DisableResult'
        },
        {
          method_name:   :list_recurring_details,
          request_class: 'Adyen::Recurring::RecurringDetailsRequest',
          result_class:  'Adyen::Recurring::RecurringDetailsResult'
        },
        {
          method_name:   :schedule_account_updater,
          request_class: 'Adyen::Recurring::ScheduleAccountUpdaterRequest',
          result_class:  'Adyen::Recurring::ScheduleAccountUpdaterResult'
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
