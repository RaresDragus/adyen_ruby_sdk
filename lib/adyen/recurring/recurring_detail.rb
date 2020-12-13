# Namespace module for gem
module Adyen
  # Namespace for recurring objects that are used throughout the Adyen API
  module Recurring
    # @!attribute [rw] additional_data
    #   @return [Object] This field contains additional data, which may be returned in a particular response.
    #     The additionalData object consists of entries, each of which includes the key and value
    # @!attribute [rw] alias
    #   @return [String] The alias of the credit card number.
    #     Applies only to recurring contracts storing credit card details
    # @!attribute [rw] alias_type
    #   @return [String] The alias type of the credit card number.
    #    Applies only to recurring contracts storing credit card details
    # @!attribute [rw] bank
    #   @return [Object] A container for bank account data
    # @!attribute [rw] billing_address
    #   @return [Object] The billing address
    # @!attribute [rw] card
    #   @return [Object] A container for card data
    # @!attribute [rw] contract_types
    #   @return [Array] Types of recurring contracts
    # @!attribute [rw] creation_date
    #   @return [DateTime] The date when the recurring details were created
    # @!attribute [rw] first_psp_reference
    #   @return [String] The pspReference of the first recurring payment that created the recurring detail
    # @!attribute [rw] name
    #   @return [String] An optional descriptive name for this recurring detail
    # @!attribute [rw] payment_method_variant
    #   @return [String] The  type or sub-brand of a payment method used, e.g. Visa Debit, Visa Corporate, etc.
    # @!attribute [rw] recurring_detail_reference
    #   @return [String] The reference that uniquely identifies the recurring detail
    # @!attribute [rw] shopper_name
    #   @return [Object] The name of the shopper
    # @!attribute [rw] social_security_number
    #   @return [String] A shopper's social security number (only in countries where it is legal to collect)
    # @!attribute [rw] variant
    #   @return [String] The payment method, such as 'mc', 'visa', 'ideal', 'paypal'
    #
    class RecurringDetail < ApiObject
      attributes :additional_data, :alias, :alias_type, :bank, :billing_address, :card, :contact_type,
                 :creation_date, :first_psp_reference, :name, :payment_method_variant, :recurring_detail_reference,
                 :shopper_name, :social_security_number, :variant

      alias_attribute :card_number_alias, :alias

      validates :alias, :alias_type, :creation_date, :first_psp_reference, :recurring_detail_reference, :variant,
                presence: true
    end
  end
end
