# Namespace module for gem
module Adyen
  # Namespace for payouts objects that are used throughout the Adyen API
  module Payouts
    # Contains data that should be received by a submit request
    #
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data, which may be returned in a particular response.
    # @!attribute [rw] psp_reference
    #   @return [String] A new reference to uniquely identify this request
    # @!attribute [rw] result_code
    #   @return [String] The response: In case of success is payout-submit-received.
    #     In case of an error, an informational message is returned.
    # @!attribute [rw] refusal_reason
    #   @return [String] In case of refusal, an informational message for the reason.
    #
    class SubmitResponse < ApiObject
      attributes :additional_data, :psp_reference, :result_code, :refusal_reason

      validates :psp_reference, :result_code, presence: true
    end
  end
end
