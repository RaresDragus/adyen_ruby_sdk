# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # Contains authentication data produced by the final CRes.
    #
    # @!attribute [rw] authentication_value
    #   @return [String] The authenticationValue value as defined in the 3D Secure 2 specification.
    # @!attribute [rw] ds_trans_ID
    #   @return [String] The dsTransID value as defined in the 3D Secure 2 specification.
    # @!attribute [rw] eci
    #   @return [String] The eci value as defined in the 3D Secure 2 specification.
    # @!attribute [rw] message_version
    #   @return [String] The messageVersion value indicating the 3D Secure 2 protocol version.
    # @!attribute [rw] threeds_server_trans_ID
    #   @return [String] The threeDSServerTransID value as defined in the 3D Secure 2 specification.
    # @!attribute [rw] timestamp
    #   @return [String] The timestamp value of the 3D Secure 2 authentication.
    # @!attribute [rw] trans_status
    #   @return [String] The transStatus value as defined in the 3D Secure 2 specification.
    # @!attribute [rw] trans_status_reason
    #   @return [String] The transStatusReason value as defined in the 3D Secure 2 specification.
    # @!attribute [rw] white_list_status
    #   @return [String] The whiteListStatus value as defined in the 3D Secure 2 specification.
    #
    class ThreeDS2Result < ApiObject
      attributes :authentication_value, :ds_trans_ID, :eci, :message_version, :threeds_server_trans_ID, :timestamp,
                 :trans_status, :trans_status_reason, :white_list_status
    end
  end
end
