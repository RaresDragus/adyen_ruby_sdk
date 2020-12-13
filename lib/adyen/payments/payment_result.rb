# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # The generic payment response from an /authorise call
    #
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data, which may be required for a particular payment request.
    #     The additionalData object consists of entries, each of which includes the key and value.
    # @!attribute [rw] auth_code
    #   @return [String] Authorisation code: When the payment is authorised successfully,
    #     this field holds the authorisation code for the payment. When the payment is not authorised,
    #     this field is empty. If a payment authorisation response includes resultCode and refusalReason,
    #     it means that the transaction either failed or was declined.
    #     Check their values for further details about any issues that affected the operation.
    # @!attribute [rw] dcc_amount
    #   @return [Hash]
    # @!attribute [rw] dcc_signature
    #   @return [String]
    # @!attribute [rw] fraud_result
    #   @return [Hash] The fraud result properties of the payment
    # @!attribute [rw] issuer_url
    #   @return [String] The URL to direct the shopper to. In case of SecurePlus, do not redirect a shopper to this URL
    # @!attribute [rw] md
    #   @return [String] The payment session
    # @!attribute [rw] pa_request
    #   @return [String] The 3D request data for the issuer. If the value is CUPSecurePlus-CollectSMSVerificationCode,
    #     collect an SMS code from the shopper and pass it in the authorise3D request
    # @!attribute [rw] psp_reference
    #   @return [String] Adyen's 16-digit unique reference associated with the transaction/the request.
    #     This value is globally unique; quote it when communicating with us about this request
    # @!attribute [rw] refusal_reason
    #   @return [String] When the payment is not authorised, it is refused, or if an error occurs,
    #     this field holds Adyen's mapped reason for the refusal or a description of the error.
    #     When a payment authorisation response includes resultCode and refusalReason, the transaction failed or
    #     was declined. Check their values to know the issues that affected the operation
    # @!attribute [rw] result_code
    #   @return [String] The outcome of the payment. The possible values are: Authorised, Refused, Error, Cancelled,
    #     Received, RedirectShopper
    #
    class PaymentResult < ApiObject
      attributes :additional_data, :auth_code, :dcc_amount, :dcc_signature, :fraud_result, :issuer_url, :md,
                 :pa_request, :psp_reference, :refusal_reason, :result_code

      validates :auth_code, :psp_reference, :result_code, presence: true
      validates :result_code, inclusion: { in: %w[Authorized Refused Error Cancelled Received RedirectShopper] }
    end
  end
end
