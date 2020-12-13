# Namespace module for gem
module Adyen
  # Namespace for Hpp objects that are used throughout the Adyen API
  module Hpp
    # Class used to create the merchant signature
    class Signature
      class << self
        # Adds merchantAccount, skinCode, and merchantSig to the required params
        # @param [Hash] req_params The required params to sign.
        # @return [Hash] Completed params
        def sign(req_params)
          params                    = req_params.dup
          params['merchantAccount'] =
            Adyen::Connection.config.merchant_account[params.dig('countryCode').downcase.to_sym || :de]
          params['skinCode']        = Adyen::Connection.config.skin_code
          params.delete('merchantSig')
          params['merchantSig'] = merchant_signature(params)
          params
        end

        private

        # Creates a custom signature for a hash
        # @param [Hash] params The parameters to be sign.
        # @return [String] The signature
        def merchant_signature(params)
          Base64.encode64(
            OpenSSL::HMAC.digest(
              OpenSSL::Digest.new('sha256'),
              Array(Adyen::Connection.config.hmac_key).pack('H*'),
              custom_string(params)
            )
          ).strip
        end

        # Creates a custom string for a hash
        # @param [Hash] params The parameters
        # @return [String] The signature
        def custom_string(params)
          custom_sort_hash(params).map do |element|
            escape_value(element)
          end.join(':')
        end

        # Creates an array from keys and values of an hash
        # @param [Hash] params The parameters
        # @return [Array<Object>]
        def custom_sort_hash(params)
          sort_keys(params) + sort_values(params)
        end

        # @return [Array<Symbol>] Sorted keys
        def sort_keys(params)
          params.sort.map { |element| element[0] }
        end

        # @return [Array<Object>] Sorted values
        def sort_values(params)
          params.sort.map { |element| element[1] }
        end

        # @return [String] Escaped value
        def escape_value(value)
          value.gsub(':', '\\:').gsub('\\', '\\\\')
        end
      end
    end
  end
end
