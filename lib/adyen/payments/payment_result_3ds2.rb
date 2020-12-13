# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # The generic payment response from an /authorise3ds2 call
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
    #   @return [Hash] Includes the currency of the conversion and the value of the transaction.
    # @!attribute [rw] dcc_signature
    #   @return [String] Cryptographic signature used to verify dccQuote.
    # @!attribute [rw] fraud_result
    #   @return [Hash] The fraud result properties of the payment
    # @!attribute [rw] issuer_url
    #   @return [String] The URL to direct the shopper to. In case of SecurePlus, do not redirect a shopper to this URL
    # @!attribute [rw] md
    #   @return [String] The payment session
    # @!attribute [rw] pa_request
    #   @return [String] The 3D request data for the issuer. If the value is CUPSecurePlus-CollectSMSVerificationCode,
    #                    collect an SMS code from the shopper and pass it in the authorise3D request
    # @!attribute [rw] psp_reference
    #   @return [String] Adyen's 16-digit unique reference associated with the transaction/the request.
    #                    This value is globally unique; quote it when communicating with us about this request
    # @!attribute [rw] refusal_reason
    #   @return [String] When the payment is not authorised, it is refused, or if an error occurs,
    #                    this field holds Adyen's mapped reason for the refusal or a description of the error.
    #                    When a payment authorisation response includes resultCode and refusalReason,
    #                    the transaction failed or was declined. Check their values to know the issues that affected
    #                    the operation
    # @!attribute [rw] result_code
    #   @return [String] The result of the payment. Possible values:
    #                    AuthenticationFinished - The payment has been successfully authenticated with 3D Secure 2.
    #                                             Returned for 3D Secure 2 authentication-only transactions.
    #                    Authorised             - The payment was successfully authorised. This state serves as an
    #                                             indicator to proceed with the delivery of goods and services.
    #                                             This is a final state.
    #                    Cancelled              - Indicates the payment has been cancelled (either by the shopper or
    #                                             the merchant) before processing was completed. This is a final state.
    #                    ChallengeShopper       - The issuer requires further shopper interaction before the payment can
    #                                             be authenticated. Returned for 3D Secure 2 transactions.
    #                    Error                  - There was an error when the payment was being processed. The reason is
    #                                             given in the refusalReason field. This is a final state.
    #                    IdentifyShopper        - The issuer requires the shopper's device fingerprint before the
    #                                             payment can be authenticated. Returned for 3D Secure 2 transactions.
    #                    Pending                - Indicates that it is not possible to obtain the final status of the
    #                                             payment. This can happen if the systems providing final status
    #                                             information for the payment are unavailable, or if the shopper needs
    #                                             to take further action to complete the payment.
    #                    PresentToShopper       - Indicates that the response contains additional information that you
    #                                             need to present to a shopper, so that they can use it to complete a
    #                                             payment.
    #                    Received               - Indicates the payment has successfully been received by Adyen, and
    #                                             will be processed. This is the initial state for all payments.
    #                    RedirectShopper        - Indicates the shopper should be redirected to an external web page or
    #                                             app to complete the authorisation.
    #                    Refused                - Indicates the payment was refused. The reason is given in the
    #                                             refusalReason field. This is a final state.
    #
    class PaymentResult3ds2 < ApiObject
      attributes :additional_data, :auth_code, :dcc_amount, :dcc_signature, :fraud_result, :issuer_url, :md,
                 :pa_request, :psp_reference, :refusal_reason, :result_code

      validates :auth_code, :psp_reference, :result_code, presence: true
      validates :result_code, inclusion: {
        in: %w[AuthenticationFinished Authorized Cancelled ChallengeShopper Error IdentifyShopper Pending
               PresentToShopper Received RedirectShopper Refused]
      }
    end
  end
end
