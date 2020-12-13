# Namespace module for gem
module Adyen
  # Namespace for payouts objects that are used throughout the Adyen API
  module Payouts
    # Contains data that should be received by a modify request
    #
    # @!attribute [rw] psp_reference
    #   @return [String] A new reference to uniquely identify this request
    # @!attribute [rw] response
    #   @return [String] The response: In case of success, it is either payout-confirm-received or
    #     payout-decline-received. In case of an error, an informational message is returned.
    #
    class ModifyResponse < ApiObject
      attributes :psp_reference, :response

      validates :psp_reference, :response, presence: true
    end
  end
end
