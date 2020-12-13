# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # Contains authentication data produced by an MPI (Mastercard SecureCode or Verified By Visa).
    #
    # @!attribute [rw] acquirer_BIN
    #   @return [String] Required for authentication-only integration. The acquiring BIN enrolled for 3D Secure 2.
    #                    This string should match the value that you will use in the authorisation.
    # @!attribute [rw] acquirer_merchant_ID
    #   @return [String] Required for authentication-only integration. The merchantId that is enrolled for 3D Secure 2
    #                    by the merchant's acquirer. This string should match the value that you will use in the
    #                    authorisation.
    # @!attribute [rw] authentication_only
    #   @return [Boolean] If set to true, you will only perform the 3D Secure 2 authentication,
    #                    and not the payment authorisation.
    # @!attribute [rw] challenge_indicator
    #   @return [String] Possibility to specify a preference for receiving a challenge from the issuer. Allowed values:
    #                    noPreference, requestNoChallenge, requestChallenge, requestChallengeAsMandate
    # @!attribute [rw] device_channel
    #   @return [String] The environment of the shopper. Allowed values: app, browser
    # @!attribute [rw] device_render_options
    #   @return [Hash] Display options for the 3D Secure 2 SDK. Optional and only for deviceChannel app.
    # @!attribute [rw] mcc
    #   @return [String] Required for merchants that have been enrolled for 3DS2 by another party than Adyen,
    #                    mostly authentication-only integrations. The mcc is a four-digit code with which
    #                   the previously given acquirerMerchantID is registered at the scheme.
    # @!attribute [rw] merchant_name
    #   @return [String] Required for authentication-only integration. The merchant name that the issuer presents to
    #                    the shopper if they get a challenge. We recommend to use the same value that you will use in
    #                    the authorization. Maximum length is 40 characters.
    # @!attribute [rw] message_version
    #   @return [String] The messageVersion value indicating the 3D Secure 2 protocol version.
    # @!attribute [rw] notification_url
    #   @return [String] URL to where the issuer should send the CRes. Required if you are not using components for
    #                    channel Web or if you are using classic integration deviceChannel browser.
    # @!attribute [rw] sdk_app_ID
    #   @return [String] The sdkAppID value as received from the 3D Secure 2 SDK. Required for deviceChannel set to app.
    # @!attribute [rw] sdk_enc_data
    #   @return [String] The sdkEncData value as received from the 3D Secure 2 SDK. Required for
    #                    deviceChannel set to app.
    # @!attribute [rw] sdk_ephem_pub_key
    #   @return [Hash] The sdkEphemPubKey value as received from the 3D Secure 2 SDK.
    #                  Required for deviceChannel set to app.
    # @!attribute [rw] sdk_max_timeout
    #   @return [Integer] The maximum amount of time in minutes for the 3D Secure 2 authentication process. Optional
    #                     and only for deviceChannel set to app. Defaults to 60 minutes.
    # @!attribute [rw] sdk_reference_number
    #   @return [String] The sdkReferenceNumber value as received from the 3D Secure 2 SDK.
    #                    Only for deviceChannel set to app.
    # @!attribute [rw] sdk_trans_ID
    #   @return [String] The sdkTransID value as received from the 3D Secure 2 SDK. Only for deviceChannel set to app.
    # @!attribute [rw] threeds_comp_ind
    #   @return [String] Completion indicator for the device fingerprinting.
    # @!attribute [rw] threeds_requestor_ID
    #   @return [String] Required for authentication-only integration for Visa. Unique 3D Secure requestor identifier
    #                    assigned by the Directory Server when you enrol for 3D Secure 2.
    # @!attribute [rw] threeds_requestor_name
    #   @return [String] Required for authentication-only integration for Visa. Unique 3D Secure requestor name
    #                    assigned by the Directory Server when you enrol for 3D Secure 2.
    # @!attribute [rw] threeds_requestor_URL
    #   @return [String] URL of the (customer service) website that will be shown to the shopper in case of technical
    #                    errors during the 3D Secure 2 process.
    # @!attribute [rw] white_list_status
    #   @return [String] The whiteListStatus value returned from a previous 3D Secure 2 transaction, only applicable
    #                    for 3D Secure 2 protocol version 2.2.0.
    #
    class ThreeDS2RequestData < ApiObject
      attributes :acquirer_BIN, :acquirer_merchant_ID, :authentication_only, :challenge_indicator, :device_channel,
                 :device_render_options, :mcc, :merchant_name, :message_version, :notification_URL, :sdk_app_ID,
                 :sdk_enc_data, :sdk_ephem_pub_key, :sdk_max_timeout, :sdk_reference_number, :sdk_trans_ID,
                 :threeds_comp_ind, :threeds_requestor_ID, :threeds_requestor_name, :threeds_requestor_URL,
                 :white_list_status

      validates :device_channel, presence: true
    end
  end
end
