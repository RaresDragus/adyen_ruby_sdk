# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # Container for card data
    #
    # @!attribute [rw] cvc
    #   @return [String] The card verification code
    # @!attribute [rw] expiry_month
    #   @return [String] The card expiry month. Format: 2 digits, zero-padded for single digits
    # @!attribute [rw] expiry_year
    #   @return [String] The card expiry year. Format: 4 digits
    # @!attribute [rw] holder_name
    #   @return [String] The name of the card holder, as printed on the card
    # @!attribute [rw] issue_number
    #   @return [String] The issue number of the card (for some UK debit cards only)
    # @!attribute [rw] number
    #   @return [String] The card number. Do not use any separators.
    # @!attribute [rw] start_month
    #   @return [String] The month component of the start date (for some UK debit cards only)
    # @!attribute [rw] start_year
    #   @return [String] The year component of the start date (for some UK debit cards only)
    #
    class Card < ApiObject
      attributes :cvc, :expiry_month, :expiry_year, :holder_name, :issue_number, :number, :start_month, :start_year

      validates :expiry_month, :expiry_year, :holder_name, :number, presence: true
      validates :cvc,          length: { in: 1..20 }
      validates :number,       length: { in: 4..19 }
      validates :expiry_month, length: { is: 2 }
      validates :expiry_year,  length: { is: 4 }

      # @note This version is compatible with adyen-cse-ruby-2 [https://github.com/vbanthia/adyen-cse-ruby, ~> 2.0]
      # @note This has not been updated with master of adyen-cse-ruby
      def encode
        cse = AdyenCse::Encrypter.new(Adyen::Connection.config.public_key)
        encrypted_card = cse.encrypt!(
          holder_name:  holder_name,
          number:       number.to_s,
          expiry_month: expiry_month,
          expiry_year:  expiry_year,
          cvc:          cvc
        )
        { 'card.encrypted.json' => encrypted_card }
      end

      # # @note This version is compatible with adyen-cse-ruby [https://github.com/jooeycheng/adyen-cse-ruby, ~> 1.0]
      # # @note This has compatibiliy issues with MRI 2.4.3+ ; see https://github.com/jooeycheng/adyen-cse-ruby/issues/4
      # def encode
      #   {
      #     'card.encrypted.json' => AdyenCse::Encrypter.new(
      #       Adyen::Connection.config.public_key
      #     ).encrypt!(
      #       holder_name: holder_name, number: number,
      #       expiry_month: expiry_month, expiry_year: expiry_year, cvc: cvc
      #     )
      #   }
      # end
    end
  end
end
