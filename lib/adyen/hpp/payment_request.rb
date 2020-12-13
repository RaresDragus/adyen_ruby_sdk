# Namespace module for gem
module Adyen
  # Namespace for Hpp objects that are used throughout the Adyen API
  module Hpp
    # Class for Hosted Payments Pages
    #
    # @!attribute [rw] merchant_reference
    #   @return [String]A reference to uniquely identify the payment. This reference is used in all communication with
    #     you about the payment status. We recommend using a unique value per payment; however, it is not a requirement.
    #     If you need to provide multiple references for a transaction, you can enter them in this field.
    #     Separate each reference value with a hyphen character ("-").
    #     This field has a length restriction: you can enter max. 80 characters.
    # @!attribute [rw] payment_amount
    #   @return [Integer] The payable amount that can be charged for the transaction, in minor units.
    # @!attribute [rw] currency_code
    #   @return [String] The three-character ISO currency code.
    # @!attribute [rw] ship_before_date
    #   @return [String] The date within which the ordered goods or services need to be shipped or
    #     provided to the shopper.
    # @!attribute [rw] merchant_account
    #   @return [String] The merchant account identifier you want to process the (transaction) request with.
    # @!attribute [rw] shopper_locale
    #   @return [String] It specifies the language to use during the transaction.
    # @!attribute [rw] order_data
    #   @return [String] An HTML fragment containing the order details to display to the shopper on the payment review
    #     page, just before the shopper proceeds to the final order confirmation. Data is compressed and encoded in the
    #     session to prevent data corruption, for example in case the locale is set to non-Latin character sets.
    #     Compression: GZIP and Encoding: Base64
    # @!attribute [rw] session_validity
    #   @return [DateTime] The payment deadline; the payment needs to occur within the specified time value.
    #     This is especially useful for tickets and reservations, where you want to hold items for sale for a short,
    #     limited period of time. Format: ISO 8601;  YYYY-MM-DDThh:mm:ssTZD Example: 2017-07-17T13:42:40+01:00
    # @!attribute [rw] merchant_return_data
    #   @return [String] This field value is appended as-is to the return URL when the shopper completes, or abandons,
    #     the payment process and is redirected to your web shop. Typically, this field is used to hold and transmit a
    #     session ID. Maximum allowed character length: 128 characters. If by including merchantReturnData in a request
    #     causes it to exceed the allowed maximum size, the payment can fail.
    # @!attribute [rw] country_code
    #   @return [String] By default, the payment methods offered to a shopper are filtered based on the country the
    #     shopper's IP address is mapped to. In this way, shoppers are not offered payment methods that are not
    #     available in the country they are carrying out the transaction from. This IP-to-country mapping is not 100%
    #     accurate, so if you have already established the country of the shopper, you can set it explicitly in the
    #     countryCode parameter. The country value format needs to adhere to the ISO 3166-1 alpha-2 standard.
    #     An invalid country code results in a transaction/request rejection. This field may be required in a payment
    #     request call to directory.shtml to perform a directory lookup.
    # @!attribute [rw] shopper_email
    #   @return [String] A shopper's email address. We recommend providing this information, as it is used in velocity
    #     fraud checks.
    # @!attribute [rw] shopper_reference
    #   @return [String] A unique identifier for the shopper, for example, a customer ID. We recommend providing this
    #     information, as it is used in velocity fraud checks. and it is the key in recurring payments.
    #     This field is mandatory in recurring payments.
    # @!attribute [rw] offset
    #   @return [Integer] An integer value that adds up to the normal fraud score.
    #     The value can be either a positive or negative integer.
    # @!attribute [rw] brand_code
    #   @return [String] Defines the specific payment method used to process the payment. This field is required in a
    #     payment request call to skipDetails.shtml to skip the payment method selection.
    # @!attribute [rw] issuer_id
    #   @return [String] Defines the specific issuer ID used to process the payment. This field is required in a payment
    #     request call to skipDetails.shtml to skip the payment method selection.
    # @!attribute [rw] offer_email
    #   @return [String] If offerEmail is set to prompt, an extra Pay by Email payment method is added to the available
    #     payment method list. If the shopper selects this option, they receive an email with a link that they can use
    #     to complete the payment. The sessionValidity time value determines the link validity.
    # @!attribute [rw] res_URL
    #   @return [String] Defines the result URL, i.e. the default result landing page shoppers are redirected to when
    #     they complete a payment on the HPP. We recommend setting a fixed resultURL in the skin configuration.
    #     However, sometimes it may be preferable to set the result URL on a per-payment basis: to override the
    #     resultURL value specified in the skin configuration, you need to set the result URL for the payment session
    #     with the resURL parameter.
    # @!attribute [rw] metadata
    #   @return [Object] Metadata consists of entries, each of which includes a key and a value.
    # @!attribute [rw] recurring_contract
    #   @return [Object] The recurring properties of the payment.
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
    #
    class PaymentRequest < ApiObject
      attributes :merchant_reference, :payment_amount, :currency_code, :ship_before_date, :shopper_locale, :order_data,
                 :session_validity, :merchant_return_data, :country_code, :shopper_email, :shopper_reference,
                 :allowed_methods, :blocked_methods, :offset, :brand_code, :issuer_id, :offer_email, :res_URL, :meta,
                 :billing_address, :recurring_contract, :shopper_interaction

      validates :merchant_reference, :payment_amount, :currency_code, :ship_before_date, :session_validity,
                presence: true
    end
  end
end
