# Namespace module for gem
module Adyen
  # Namespace for basic objects that are used throughout the Adyen API
  module Common
    # Provides fields to hold information on the funds amount
    #
    # @!attribute [rw] currency
    #   @return [String] The three-character ISO currency code
    # @!attribute [rw] value
    #   @return [Integer] The payable amount that can be charged for the transaction
    #
    class Amount < ApiObject
      attributes :currency, :value

      validates :currency, :value, presence:     true
      validates :currency,         length:       { is: 3 }
      validates :value,            numericality: { only_integer: true }
    end
  end
end
