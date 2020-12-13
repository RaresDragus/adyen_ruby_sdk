# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # The fields described below are the generic payment fields you specify when making an /authorise3ds2 call
    # to the Adyen payment API.
    #
    # @!attribute [rw] additional_amount
    #   @return [Hash] A container for the data concerning the additional amount to be authorised.
    # If you want a BIN or card verification request to use a non-zero value, assign this value to additionalAmount
    # (while the amount must be still set to 0 to trigger BIN or card verification).
    # Required to be in the same currency as the amount.
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data, which may be required for a particular payment request.
    # The additionalData object consists of entries, each of which includes the key and value.
    # @!attribute [rw] amount
    #   @return [Hash] The amount information for the transaction.
    # For BIN or card verification requests, set amount to 0 (zero).
    # @!attribute [rw] application_info
    #   @return [Hash] Information about your application.
    # @!attribute [rw] billing_address
    #   @return [Hash] The address where to send the invoice
    # @!attribute [rw] browser_info
    #   @return [Hash] A user's browser information
    # @!attribute [rw] capture_delay_hours
    #   @return [Integer] The delay between the authorisation and scheduled auto capture, specified in hours
    # @!attribute [rw] date_of_birth
    #   @return [String] The shopper's date of birth. Format: ISO-8601; example: YYYY-MM-DD
    # @!attribute [rw] dcc_quote
    #   @return [Object] The forex quote as returned in the response of the forex service
    # @!attribute [rw] delivery_address
    #   @return [Object] The address where the purchased goods should be delivered to
    # @!attribute [rw] delivery_date
    #   @return [DateTime] The date and time the purchased goods should be delivered.
    #     Format: ISO 8601;  YYYY-MM-DDThh:mm:ss.sssTZD Example: 2017-07-17T13:42:40.428+01:00
    # @!attribute [rw] device_fingerprint
    #   @return [String] A string containing a shopper's device fingerprint
    # @!attribute [rw] fraud_offset
    #   @return [Integer] An integer value that is added to the normal fraud score.
    #     The value can be either positive or negative
    # @!attribute [rw] installments
    #   @return [Object] Contains information on an installment
    # @!attribute [rw] mcc
    #   @return [String] The merchant category code (MCC) is a four-digit number
    #     which relates to a particular market segment.
    #     This code reflects the predominant activity that is conducted by the merchant.
    # @!attribute [rw] merchant_account
    #   @return [String] The merchant account identifier you want to process the (transaction) request with.
    #     This value must correspond to the merchantAccount used in the original /authorise call
    # @!attribute [rw] merchant_order_reference
    #   @return [String] This reference allows linking multiple transactions to each other.
    #     When providing the merchantOrderReference value, we also recommend you submit retry.orderAttemptNumber,
    #     retry.chainAttemptNumber, and retry.skipRetry values
    # @!attribute [rw] merchant_risk_indicator
    #   @return [Hash] Additional risk fields for 3D Secure 2.
    # @!attribute [rw] metadata
    #   @return [Hash] Metadata consists of entries, each of which includes a key and a value.
    # @!attribute [rw] order_reference
    #   @return [String] The order reference to link multiple partial payments
    # @!attribute [rw] recurring
    #   @return [Hash] The recurring properties of the payment.
    #     Specify this property when you want to enable recurring payments
    # @!attribute [rw] recurring_processing_model
    #   @return [String] Defines a recurring payment type. Allowed values:
    # Subscription          - A transaction for a fixed or variable amount, which follows a fixed schedule.
    # CardOnFile            - Card details are stored to enable one-click or omnichannel journeys, or simply
    #                         to streamline the checkout process. Any subscription not following a fixed schedule is
    #                         also considered a card-on-file transaction.
    # UnscheduledCardOnFile - A transaction that occurs on a non-fixed schedule and/or have variable amounts.
    #                         For example, automatic top-ups when a cardholder's balance drops below a certain amount.
    # @!attribute [rw] reference
    #   @return [String] A reference to uniquely identify the payment. This reference is used in all communication
    #     with you about the payment status. We recommend using a unique value per payment;
    #     however, it is not a requirement. If you need to provide multiple references for a transaction,
    #     you can enter them in this field. Separate each reference value with a hyphen character ("-").
    #     This field has a length restriction: you can enter max. 80 characters.
    # @!attribute [rw] selected_brand
    #   @return [String] Some payment methods require defining a value for this field to specify how to process
    #     the transaction. For the MisterCash payment method, it can be set to:
    #     maestro (default), to be processed like a Maestro card, or bcmc, to be processed like a MisterCash card.
    # @!attribute [rw] selected_recurring_detail_reference
    #   @return [String] The recurringDetailReference you want to use for this payment.
    #     The value 'LATEST' can be used to select the most recently stored recurring detail.
    # @!attribute [rw] session_id
    #   @return [String] A session identifier used to identify a payment session
    # @!attribute [rw] shopper_email
    #   @return [String] The shopper's email address.
    #     We recommend you provide this data, as it is used in velocity fraud checks
    # @!attribute [rw] shopper_IP
    #   @return [String] The shopper's IP address.
    #     We recommend you provide this data, as it is used in a number of risk checks.
    #     For example: number of payment attempts, location based checks. This field is mandatory for some merchants
    #     depending on your business model
    # @!attribute [rw] shopper_interaction
    #   @return [String] Specifies the following information:
    #     The sales channel the shopper gives their card details through;
    #     Whether the shopper is a returning customer.
    #
    #     By default, for the web service API Adyen assumes Ecommerce shopper interaction.
    #     This field has the following possible values:
    #        Ecommerce - Online transactions where the cardholder is present (online). For better authorisation rates,
    #                    we recommend sending the card security code (CSC) along with the request.
    #        ContAuth -  Card on file and/or subscription transactions, where the card holder is known to the merchant
    #                    (returning customer). If the shopper is present (online), you can supply also the CSC to
    #                    improve authorisation (one-click payment).
    #        POS -       Point-of-sale transactions where the shopper is physically present to make a payment
    #                    using a secure payment terminal.
    #        Moto -      Mail-order and telephone-order transactions where the shopper is in contact with the merchant
    #                    via email or telephone
    # @!attribute [rw] shopper_locale
    #   @return [String] The combination of a language code and a country code to specify the language to be used
    #     in the payment
    # @!attribute [rw] shopper_name
    #   @return [Hash] A shopper's full name and gender (if specified)
    # @!attribute [rw] shopper_reference
    #   @return [String] A shopper's reference for the payment transaction. We recommend you provide this data.
    #     This field is required for recurring payments
    # @!attribute [rw] shopper_statement
    #   @return [String] The text to appear on the shopper's bank statement.
    # @!attribute [rw] social_security_number
    #   @return [String] A shopper's social security number
    # @!attribute [rw] splits
    #   @return [Array<Hash>] The details of how the payment should be split when distributing a payment to a
    #                         MarketPay Marketplace and its Accounts.
    # @!attribute [rw] store
    #   @return [String] The physical store, for which this payment is processed.
    # @!attribute [rw] telephone_number
    #   @return [String] A shopper's telephone number. This field is mandatory in case of Secure+ authorise requests.
    #     The country code should be preceded with a + sign.
    # @!attribute [rw] threeds2_request_data
    #   @return [Hash] Request fields for 3D Secure 2.
    # @!attribute [rw] threeds2_result
    #   @return [Hash] The ThreeDS2Result that was returned in the final CRes.
    # @!attribute [rw] threeds2_token
    #   @return [String] The ThreeDS2Token that was returned in the /authorise call.
    # @!attribute [rw] totals_group
    #   @return [String] The reference value to aggregate sales totals in reporting.
    # When not specified, the store field is used (if available).
    # @!attribute [rw] trusted_shopper
    #   @return [String] Set to true if the payment should be routed to a trusted MID.
    #
    class PaymentRequest3ds2 < ApiObject
      attributes :additional_amount, :additional_data, :amount, :application_info, :billing_address, :browser_info,
                 :capture_delay_hours, :date_of_birth, :dcc_quote, :delivery_address, :delivery_date,
                 :delivery_fingerprint, :fraud_offset, :installments, :mcc, :merchant_account,
                 :merchant_order_reference, :merchant_risk_indicator, :metadata, :order_reference, :recurring,
                 :recurring_processing_model, :reference, :selected_brand, :selected_recurring_detail_reference,
                 :session_id, :shopper_email, :shopper_IP, :shopper_interaction, :shopper_locale, :shopper_name,
                 :shopper_reference, :shopper_statement, :social_security_number, :splits, :store, :telephone_number,
                 :threeds2_request_data, :threeds2_result, :threeds2_token, :totals_group, :trusted_shopper

      before_validation :set_merchant_account

      validates :merchant_account, :threeds2_token, presence: true
      validates :reference, length: { maximum: 80 }
      validates :shopper_interaction, inclusion: { in: %w[Ecommerce ContAuth POS Moto] }, allow_blank: true
    end
  end
end
