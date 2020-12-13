# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    #  Contains data to be send as a modification request to the /capture endpoint
    #
    # @!attribute [rw] merchant_account
    #   @return [String] The merchant account where the transaction, for which the request needs to be initiated,
    #     was processed
    # @!attribute [rw] modification_amount
    #   @return [Hash] The amount to capture. The  currency must match the currency used in the original
    #     payment request. The value must be smaller than or equal to the authorised amount
    # @!attribute [rw] original_reference
    #   @return [String] The  originalReference value corresponds to the  pspReference value assigned to
    #     the original payment. You receive the pspReference with: The payment status, or the authorisation notification
    # @!attribute [rw] reference
    #   @return [String] If you want, you can specify your reference for the modification request.
    #     The reference is visible in the Merchant Backoffice and in the reporting section. This field has a
    #     length restriction: you can enter max. 80 characters
    #
    class CaptureModificationRequest < ApiObject
      attributes :merchant_account, :modification_amount, :original_reference, :reference

      before_validation :set_merchant_account

      validates :merchant_account, :modification_amount, :original_reference, presence: true
      validates :reference, length: { maximum: 80 }
    end
  end
end
