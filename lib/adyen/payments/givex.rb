# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # Holds information on the results of a fraud risk check
    #
    # @!attribute [rw] cvc
    #   @return [String] If you choose to ask your shopper for the PIN while making the payment.
    #     Use this field to enter the gift card PIN.
    # @!attribute [rw] expiry_month
    #   @return [String] The gift card expiry month
    # @!attribute [rw] expiry_year
    #   @return [String] The gift card expiry year
    # @!attribute [rw] holder_name
    #   @return [String] The name of the gift card holder
    # @!attribute [rw] number
    #   @return [String] The gift card number. Do not use any separators
    # @!attribute [rw] additional_data
    #   @return [Hash] Additional data container. Contains: Key, Value. Use this object to deactivate a gift card
    # @!attribute [rw] key
    #   @return [String] Expected value: stored_value_redemption_type
    # @!attribute [rw] value
    #   @return [String] Expected value: deactivate
    #
    class Givex < ApiObject
      attributes :cvc, :expiry_month, :expiry_year, :holder_name, :number, :additional_data, :key, :value

      validates :expiry_month, :expiry_year, :holder_name, :number, presence: true
      validates :expiry_month, length: { is: 2 }
      validates :expiry_year,  length: { is: 4 }
      validates :number,       length: { in: 4..19 }
    end
  end
end
