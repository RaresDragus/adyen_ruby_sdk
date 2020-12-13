# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # Contains data returned in response to a modification request
    #
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data,
    #     which may be returned in a particular modification response
    # @!attribute [rw] psp_reference
    #   @return [String] Adyen's 16-digit unique reference associated with the transaction/the request.
    #     This value is globally unique; quote it when communicating with us about this request
    # @!attribute [rw] response
    #   @return [String] If a request is successful, the returned value contains a confirmation
    #      (e.g. [capture-received]). If it fails, an error message is returned
    #
    class ModificationResult < ApiObject
      attributes :additional_data, :psp_reference, :response

      validates :psp_reference, :response, presence: true
      validates :psp_reference, length: { is: 16 }
    end
  end
end
