# Namespace module for gem
module Adyen
  # Encapsulates logic related to the Adyen API objects
  class ApiObject
    include ActiveModel::Model
    include ActiveModel::Validations::Callbacks

    EXCEPTION_KEYS = {
      item_ID:                 'itemID',
      shopper_IP:              'shopperIP',
      res_URL:                 'resURL',
      acquirer_BIN:            'acquirerBIN',
      acquirer_merchant_ID:    'acquirerMerchantID',
      notification_URL:        'notificationURL',
      sdk_app_ID:              'sdkAppID',
      sdk_trans_ID:            'sdkTransID',
      threeds_comp_ind:        'threeDSCompInd',
      threeds_requestor_ID:    'threeDSRequestorID',
      threeds_requestor_name:  'threeDSRequestorName',
      threeds_requestor_URL:   'threeDSRequestorURL',
      threeds2_request_data:   'threeDS2RequestData',
      threeds2_result:         'threeDS2Result',
      ds_trans_ID:             'dsTransID',
      threeds_server_trans_ID: 'threeDSServerTransID',
      threeds2_token:          'threeDS2Token'
    }.freeze

    # Constructor method
    # @param [Hash] attributes Optional, the attributes for the new Adyen API Object
    def initialize(attributes = {})
      super(attributes)
    end

    # @return [Hash] Converts the object as a Hash with camelize keys
    def to_h(for_hpp:)
      for_hpp ? convert_to_hash_for_hpp : convert_to_hash_for_api
    end

    class << self
      # Getters and Setters for the instance variables
      # @param [Array<Symbol>] attr_names Array of instance variables
      def attributes(*attr_names)
        attr_names += [:merchant_country]
        class_variable_set(:@@attr_names, attr_names)

        send :cattr_accessor, :attr_names

        attr_names.each do |attr_name|
          define_method :"#{attr_name}" do
            instance_variable_get("@#{attr_name}")
          end

          define_method :"#{attr_name}=" do |value|
            instance_variable_set("@#{attr_name}", value)
          end
        end
      end

      # @return [ApiObject]
      # @param [Hash] params The "Respond Parameters" needed for new instance
      def to_object(params)
        new(
          params.each_with_object({}) do |element, result|
            result[element[0].underscore] = element[1] if attr_names.include?(element[0].underscore.to_sym)
          end
        )
      end

      # @return [ApiObject]
      # @param [Hash] params The "Request Parameters" needed for new instance
      # @param [Hash] merchant_country The merchant account country code
      def req_params(params, merchant_country)
        req_params = params.is_a?(self) ? params : new(params)
        req_params.merchant_country = merchant_country
        raise Adyen::Exceptions::InvalidApiObject, req_params.errors.full_messages if req_params.invalid?

        req_params
      end
    end

    private

    # @return [Hash] Converted object to a Hash with camelize keys for Api Request
    def convert_to_hash_for_api
      self.class.attr_names.each_with_object({}) do |attr, result|
        key = EXCEPTION_KEYS.keys.include?(attr) ? EXCEPTION_KEYS[attr] : attr.to_s.camelize(:lower)
        value = public_send(attr)
        result[key] = value if value.present?
      end
    end

    # @return [Hash] Converted object to a Hash with camelize keys for HPP
    def convert_to_hash_for_hpp
      self.class.attr_names.each_with_object({}) do |attr, result|
        value = public_send(attr)
        if value.is_a?(Hash)
          deep_conversion_to_hash({ attr => value }, '', result)
        else
          key = EXCEPTION_KEYS.keys.include?(attr) ? EXCEPTION_KEYS[attr] : attr.to_s.camelize(:lower)
          result[key] = value.to_s if value.present?
        end
      end
    end

    # Transforms a multi level hash into single level hash with camelize keys
    # @return [Hash]
    def deep_conversion_to_hash(initial_hash, prefix = '', return_hash = {})
      initial_hash.each_with_object(return_hash) do |(key, value), result|
        key = "#{prefix}#{key.to_s.camelize(:lower)}"
        if value.is_a?(Hash)
          deep_conversion_to_hash(value, "#{key}.", return_hash)
        else
          result[key] = value.to_s
        end
      end
    end

    # Sets the merchant account instance variable
    # @return [String]
    def set_merchant_account
      @merchant_account ||= Adyen::Connection.config.merchant_account[merchant_country || :de]
    end
  end
end
