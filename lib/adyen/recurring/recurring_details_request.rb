# Namespace module for gem
module Adyen
  # Namespace for recurring objects that are used throughout the Adyen API
  module Recurring
    # Contains data that should be passed in a /listRecurringDetails request.
    #
    # @!attribute [rw] merchant_account
    #   @return [String] The merchant account identifier you want to process the (transaction) request with
    # @!attribute [rw] recurring
    #   @return [Object] A container for the type of a recurring contract to be retrieved. The contract value needs to
    #     match the contract value submitted in the payment transaction used to create a recurring contract. However,
    #     if ONECLICK,RECURRING is the original contract definition in the initial payment, then contract should take
    #     either ONECLICK or RECURRING, depending on whether or not you want the shopper to enter their card's security
    #     code when they finalize their purchase
    # @!attribute [rw] shopper_reference
    #   @return [String] The shopper's reference for the payment transaction
    #
    class RecurringDetailsRequest < ApiObject
      attributes :merchant_account, :recurring, :shopper_reference

      before_validation :set_merchant_account

      validates :merchant_account, :shopper_reference, presence: true
    end
  end
end
