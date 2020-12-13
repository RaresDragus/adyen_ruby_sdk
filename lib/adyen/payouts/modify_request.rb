# Namespace module for gem
module Adyen
  # Namespace for payouts objects that are used throughout the Adyen API
  module Payouts
    # Contains data that should be passed to either confirm or decline a previously submitted payout
    #
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data, which may be required for a particular payment request
    # @!attribute [rw] merchant_account
    #   @return [String] The merchant account identifier you want to process the (transaction) request with
    # @!attribute [rw] original_reference
    #   @return [String] The PSP reference received in the submit payout response
    #
    class ModifyRequest < ApiObject
      attributes :additional_data, :merchant_account, :original_reference

      before_validation :set_merchant_account

      validates :merchant_account, :original_reference, presence: true
    end
  end
end
