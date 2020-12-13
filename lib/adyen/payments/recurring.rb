# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # A container for the type of recurring contract to be retrieved
    #
    # @!attribute [rw] contract
    #   @return [String] The type of recurring contract to be used. Possible values:
    #     ONECLICK - The shopper opts to store their card details for future use. The shopper is present for the
    #                subsequent transaction, for cards the security code (CVC/CVV) is required.
    #     RECURRING - Payment details are stored for future use. For cards, the security code (CVC/CVV) is not required
    #                for subsequent payments. This is used for shopper not present transactions.
    #     ONECLICK, RECURRING - Payment details are stored for future use. This allows the use of the stored payment
    #                details regardless of whether the shopper is on your site or not
    #
    class Recurring < ApiObject
      attributes :contract

      validates :contract, presence: true, inclusion: { in: %w[ONECLICK RECURRING RECURRING,ONECLICK PAYOUT] }
    end
  end
end
