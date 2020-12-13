# Namespace module for gem
module Adyen
  # Namespace for payouts objects that are used throughout the Adyen API
  module Payouts
    # Contains data that should be passed in either the /submit or /submitThirdParty  request to initiate a payout.
    #
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data, which may be required for a particular request
    # @!attribute [rw] amount
    #   @return [Hash] A container object for the payable amount information of the transaction
    # @!attribute [rw] date_of_birth
    #   @return [Date] The date of birth. Format: ISO-8601; example: YYYY-MM-DD. For Paysafecard it must be the same as
    #     used when registering the Paysafecard account. This field is mandatory for natural persons.
    #     This field is required to update the existing dateOfBirth that is associated with this recurring contract.
    # @!attribute [rw] entity_type
    #   @return [String] The type of the entity the payout is processed for. Allowed values: NaturalPerson, Company
    #      This field is required to update the existing entityType that is associated with this recurring contract.
    # @!attribute [rw] fraud_offset
    #   @return [Integer] An integer value that is added to the normal fraud score.
    #     The value can be either positive or negative.
    # @!attribute [rw] merchant_account
    #   @return [String] The merchant account identifier you want to process the (transaction) request with.
    # @!attribute [rw] nationality
    #   @return [String] The shopper's nationality. A valid value is an ISO 2-character country code (e.g. 'NL').
    #     This field is required to update the existing nationality that is associated with this recurring contract.
    # @!attribute [rw] recurring
    #   @return [Hash] A container for the type of recurring contract to be retrieved.
    #     The recurring.contract must be set to PAYOUT
    # @!attribute [rw] reference
    #   @return [String] The (merchant) reference for this payment. This reference will be used in all communication to
    #     the merchant about the status of the Payout payment.
    # @!attribute [rw] selected_brand
    #   @return [String] The name of the brand to make a payout to. For Paysafecard it must be set to paysafecard.
    # @!attribute [rw] selected_recurring_detail_reference
    #   @return [String] This is the recurringDetailReference you want to use for this payout.
    #     You can use the value LATEST to select the most recently used recurring detail.
    # @!attribute [rw] shopper_email
    #   @return [String] The shopper's email address
    # @!attribute [rw] shopper_name
    #   @return [Hash] The shopper's name. In case the entityType is Company, the shopperName.lastName must contain
    #     the company name. This field is required to update the existing shopperName associated with a
    #     recurring contract.
    # @!attribute [rw] shopper_reference
    #   @return [String] The shopper's reference for the payment transaction.
    # @!attribute [rw] shopper_statement
    #   @return [String] The description of this payout. This description is shown on the bank statement of the shopper
    #     (if this is supported by the chosen payment method).
    # @!attribute [rw] social_security_number
    #   @return [String] The shopper's social security number.
    #
    class SubmitRequest < ApiObject
      attributes :additional_data, :amount, :date_of_birth, :entity_type, :fraud_offset, :merchant_account,
                 :nationality, :recurring, :reference, :selected_recurring_detail_reference,
                 :shopper_email, :shopper_name, :shopper_reference, :shopper_statement, :social_security_number

      before_validation :set_merchant_account

      validates :amount, :merchant_account, :recurring, :reference, :shopper_email,
                :shopper_reference, :selected_recurring_detail_reference, presence: true
      validates :nationality, length: { is: 2 }
      validates :entity_type, inclusion: { in: %w[NaturalPerson Company] }
    end
  end
end
