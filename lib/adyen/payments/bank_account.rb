# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    #  Provides fields to hold information on bank account details
    #
    # @!attribute [rw] bank_account_number
    #   @return [String] The bank account number (without separators)
    # @!attribute [rw] bank_city
    #   @return [String] The bank city
    # @!attribute [rw] bank_location_id
    #   @return [String] The location id of the bank. The field value is nil in most cases
    # @!attribute [rw] bank_name
    #   @return [String] The name of the bank
    # @!attribute [rw] bic
    #   @return [String] The business identifier code (BIC) is the SWIFT address assigned to a bank.
    #     The field value is nil in most cases.
    # @!attribute [rw] country_code
    #   @return [String] Country code where the bank is located. A valid value is an ISO 2-character country code
    # @!attribute [rw] iban
    #   @return [String] The International Bank Account Number (IBAN)
    # @!attribute [rw] owner_name
    #   @return [String] The name of the bank account holder
    # @!attribute [rw] tax_id
    #   @return [String] Tax identification number
    #
    class BankAccount < ApiObject
      attributes :bank_account_number, :bank_city, :bank_location_id, :bank_name, :bic, :country_code, :iban,
                 :owner_name, :tax_id

      validates :bank_account_number, :bank_name, :country_code, :iban, :owner_name, presence: true
      validates :country_code, length: { is: 2 }
    end
  end
end
