# Namespace module for gem
module Adyen
  # Namespace for basic objects that are used throughout the Adyen API
  module Payments
    # Use the /voidPendingRefund endpoint to cancel a POS refund request.
    # The default approach uses the tenderReference, as this is generated in both offline and online transactions.
    #
    # @!attribute [rw] merchant_account
    #   @return [String] The merchantAccount that is refunding the money
    # @!attribute [rw] tender_reference
    #   @return [String] The transaction reference provided by the PED
    # @!attribute [rw] unique_terminal_id
    #   @return [String] Unique terminal ID for the PED that originally processed the request
    #
    class VoidPendingRefundModificationRequest < ApiObject
      attributes :merchant_account, :tender_reference, :unique_terminal_id

      before_validation :set_merchant_account

      validates :merchant_account, :tender_reference, :unique_terminal_id, presence: true
    end
  end
end
