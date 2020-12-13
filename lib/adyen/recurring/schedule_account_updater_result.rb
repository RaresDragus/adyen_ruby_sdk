# Namespace module for gem
module Adyen
  # Namespace for recurring objects that are used throughout the Adyen API
  module Recurring
    # Contains data that is returned as a response to a /scheduleAccountUpdater request.
    #
    # @!attribute [rw] psp_reference
    #   @return [String] Adyen's 16-digit unique reference associated with the transaction/the request. This value is
    #     globally unique; quote it when communicating with us about this request.
    # @!attribute [rw] result
    #   @return [String] The result of a schedule request.
    #
    class ScheduleAccountUpdaterResult < ApiObject
      attributes :psp_reference, :result

      validates :psp_reference, :result, presence: true
    end
  end
end
