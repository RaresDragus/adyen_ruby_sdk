# Namespace module for gem
module Adyen
  # Namespace for basic objects that are used throughout the Adyen API
  module Common
    # A container for the installment information
    #
    # @!attribute [rw] value
    #   @return [Integer] Defines the number of installments. Its value needs to be greater than zero.
    #
    class Installments < ApiObject
      attributes :value

      validates :value, presence: true, numericality: { only_integer: true, greater_than: 0 }
    end
  end
end
