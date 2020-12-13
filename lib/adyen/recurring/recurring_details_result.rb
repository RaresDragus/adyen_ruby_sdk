# Namespace module for gem
module Adyen
  # Namespace for recurring objects that are used throughout the Adyen API
  module Recurring
    # Contains data returned as a response to a /listRecurringDetails request
    #
    # @!attribute [rw] creation_date
    #   @return [DateTime] The date when the recurring details were created
    # @!attribute [rw] details
    #   @return [Array] A list of one or more recurring payment details
    # @!attribute [rw] last_known_shopper_email
    #   @return [String] The most recent email for this shopper (if available)
    # @!attribute [rw] shopper_reference
    #   @return [String] The reference you use to uniquely identify the shopper (e.g. user ID or account ID).
    #
    class RecurringDetailsResult < ApiObject
      attributes :creation_date, :details, :last_known_shopper_email, :shopper_reference, :invalid_oneclick_contracts

      validates :creation_date, :details, :shopper_reference, presence: true

      def recurring_details
        @recurring_details ||= []
        return @recurring_details if details.blank?

        details.each do |detail|
          @recurring_details << Adyen::Recurring::RecurringDetail.to_object(detail['RecurringDetail'])
        end
        @recurring_details
      end
    end
  end
end
