# Namespace module for gem
module Adyen
  # Namespace for recurring objects that are used throughout the Adyen API
  module Recurring
    # Contains data that should be passed in a /disable request
    #
    # @!attribute [rw] contract
    #   @return [String] Specify the contract if you only want to disable a specific use.
    #     This field can be set to one of the following values, or to their combination (comma-separated):
    #     ONECLICK, RECURRING, PAYOUT
    # @!attribute [rw] merchant_account
    #   @return [String] Your merchant account
    # @!attribute [rw] recurring_detail_reference
    #   @return [String] The ID that uniquely identifies the recurring detail reference. If it is not provided,
    #     the whole recurring contract of the shopperReference will be disabled, which includes all recurring details.
    # @!attribute [rw] shopper_reference
    #   @return [String] The ID that uniquely identifies the shopper. This shopperReference must be the same as the
    #     shopperReference used in the initial payment
    #
    class DisableRequest < ApiObject
      attributes :contract, :merchant_account, :recurring_detail_reference, :shopper_reference

      before_validation :set_merchant_account

      validates :merchant_account, :shopper_reference, presence: true
    end
  end
end
