# Namespace module for gem
module Adyen
  # Encapsulates logic for API interaction; represents a client connection
  #
  # @!attribute [r] client_key
  #   @return [String] Client Key to use for Adyen API
  # @!attribute [r] client_secret
  #   @return [String] Client Secret to use for Adyen API
  # @!attribute [r] public_key
  #   @return [String] Public Key to use for Adyen API
  # @!attribute [r] endpoint
  #   @return [String] Endpoint to use for Adyen API
  # @!attribute [r] merchant_account
  #   @return [String] The name of the account to use for Adyen API
  # @!attribute [r] skin_code
  #   @return [String] The skin code to use for Adyen API
  # @!attribute [r] hmac_key
  #   @return [String] The HMAC key to use for Adyen API
  #
  class Connection
    include Singleton
    include ActiveSupport::Configurable

    config_accessor :client_key, :client_secret, :public_key, :endpoint, :merchant_account,
                    :skin_code, :hmac_key, :request_timeout

    class << self
      # @return [Object] Performs a POST request with retry against the API and returns the parsed response
      def send_json_request(class_name, relative_url, params = {})
        with_retry do
          idempotency_key = params.delete('idempotencyKey')
          headers         = api_headers
          headers.merge('Idempotency-Key' => idempotency_key) if idempotency_key.present?
          post(api_url(class_name, relative_url), params.to_json, headers)
        end
      end

      private

      # @return [Object] Calls the block within a loop, ensuring authentication setup and renewal
      #   The block is called in turn a maximum of 3 times.
      def with_retry
        retries ||= 3
        yield
      rescue Errno::ECONNRESET, RestClient::Exceptions::Timeout
        Adyen.log.info "Retries #{retries}"
        raise Adyen::Exceptions::Timeout if (retries -= 1).zero?

        retry
      end

      # @return [Object] Performs a POST request against the API and returns the response, parsed
      def post(url, payload, headers = {})
        RestClient::Request.execute(
          method: :post, url: url, payload: payload, headers: headers, timeout: config.request_timeout
        ) do |response, request, result, &block|
          process_response(response, request, result, &block)
        end
      end

      # @return [Hash] Header for API interactions
      def api_headers
        {}.merge(content_type_json_header).merge(accept_json_header).merge(auth_basic_header)
      end

      # @return [String] Complete URL to use for API interaction
      # @param [String,Symbol] ep_key Endpoint key, identifying the service
      # @param [String] relative_url Request path within the service
      def api_url(ep_key, relative_url)
        URI.parse("#{config.endpoint[ep_key]}#{relative_url}").to_s
      end

      # @return [Hash] Authorization header, using Basic method
      def auth_basic_header
        auth_header('Basic', basic_token)
      end

      # @return [String] Token string for Authorization with Basic method
      def basic_token
        Base64.strict_encode64 "#{config.client_key}:#{config.client_secret}"
      end

      # @return [Hash] Authorization header for the method and token specified
      # @param [String] method Authorization method
      # @param [String] token Authorization token
      def auth_header(method, token)
        { authorization: "#{method} #{token}" }
      end

      # @return [Hash] JSON Content-type header
      def content_type_json_header
        { content_type: :json }
      end

      # @return [Hash] JSON Accept header
      def accept_json_header
        { accept: :json }
      end

      # @return [Object] Rest Client callback method to process the API response
      # @param [RestClient::Response] response
      # @param [RestClient::Request] _request
      # @param [Object] _result
      # @param [Block] block
      def process_response(response, _request, _result, &block)
        case response.code
        when 200..299
          parse_object(response)
        when 301, 302, 307 # :moved_permanently, :found, :temporary_redirect
          response.follow_redirection(&block)
        when 400 # :bad_request
          nil
        when 401..599
          parse_errors(response)
        else
          response.return!(&block)
        end
      end

      # @return [Hash,TrueClass] JSON parsed response or true
      # @param [RestClient::Response] response Response which body to parse
      def parse_object(response)
        if response&.body && !response&.body&.empty?
          JSON.parse(response.body)
        else
          true
        end
      end

      # @return [ServiceException,FalseClass] Service Exception Object or false
      # @param [RestClient::Response] response Response which body to parse
      def parse_errors(response)
        Adyen.log.debug response&.body
        if response&.body && !response&.body&.empty?
          Adyen::Common::ServiceException.to_object(JSON.parse(response.body))
        else
          false
        end
      end
    end
  end
end
