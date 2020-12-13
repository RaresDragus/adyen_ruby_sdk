# Namespace module for gem
module Adyen
  # Namespace for recurring objects that are used throughout the Adyen API
  module Recurring
    # Contains data that should be passed in a /scheduleAccountUpdater request.
    #
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data, which may be required for a particular payment request.
    # @!attribute [rw] card
    #   @return [Hash] A container for credit card data.
    #     Optional if shopperReference and selectedRecurringDetailReference are provided.
    # @!attribute [rw] merchant_account
    #   @return [String] The merchant account identifier you want to process the (transaction) request with
    # @!attribute [rw] reference
    #   @return [String] A reference that merchants can apply for the call.
    # @!attribute [String] selected_recurring_detail_reference
    #   @return [String] The selected detail recurring reference.
    #     Optional if all card information is provided.
    # @!attribute [rw] shopper_reference
    #   @return [String] The reference of the shopper that owns the recurring contract.
    #    Optional if all card information is provided.
    #
    class ScheduleAccountUpdaterRequest < ApiObject
      attributes :additional_data, :card, :merchant_account, :reference, :selected_recurring_detail_reference,
                 :shopper_reference

      before_validation :set_merchant_account

      validates :merchant_account, :reference, :selected_recurring_detail_reference, :shopper_reference, presence: true
    end
  end
end
