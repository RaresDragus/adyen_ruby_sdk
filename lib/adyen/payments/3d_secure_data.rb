# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # Contains authentication data produced by an MPI (Mastercard SecureCode or Verified By Visa).
    #
    # @!attribute [rw] authentication_response
    #   @return [String] The authentication response if a shopper was redirected
    # @!attribute [rw] cavv
    #   @return [String] The cardholder authentication value (base64 encoded, 20 bytes in a decoded form)
    # @!attribute [rw] cavv_algorithm
    #   @return [String] The CAVV algorithm used
    # @!attribute [rw] directory_response
    #   @return [String] The enrollment response from the 3D directory server
    # @!attribute [rw] eci
    #   @return [String] The electronic commerce indicator
    # @!attribute [rw] xid
    #   @return [String] The transaction identifier (base64 encoded, 20 bytes in a decoded form)
    #
    class ThreeDSecureData < ApiObject
      attributes :authentication_response, :cavv, :cavv_algorithm, :directory_response, :eci, :xid
    end
  end
end
