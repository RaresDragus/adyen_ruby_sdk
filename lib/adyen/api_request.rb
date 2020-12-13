# Namespace module for gem
module Adyen
  # Encapsulates logic related to the Adyen API Request objects
  class ApiRequest
    class << self
      protected

      # @return [String] A relative URL used for the API endpoint
      # @param [Symbol] method_name The name of the method
      def relative_url(method_name)
        @relative_url = method_name.to_s.camelize(:lower)
      end

      # @return [Symbol] Custom symbol based on the class name
      def class_name_to_sym
        name.demodulize.underscore.downcase.split('_')[0].to_sym
      end

      # Executes the Api Request and maps the result into an Adyen Object
      # @return [Adyen::ApiObject, Adyen::Common::ServiceException]
      def execute_json_request(result_class_name, params)
        result = Adyen::Connection.send_json_request(
          class_name_to_sym,
          @relative_url,
          params.to_h(for_hpp: false)
        )
        if result.is_a?(Adyen::Common::ServiceException)
          result
        elsif %w[status errorCode message errorType].all? { |str| result.has_key? str }
          Adyen::Common::ServiceException.to_object(result)
        else
          result_class_name.constantize.to_object(result)
        end
      rescue RestClient::Exception => e
        e.message
      end
    end
  end
end
