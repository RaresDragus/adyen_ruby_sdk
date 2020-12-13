# Namespace module for gem
module Adyen
  # Namespace for basic objects that are used throughout the Adyen API
  module Common
    # Provides the response message when the API request is rejected
    #
    # @!attribute [rw] status
    #   @return [String] Returns the HTTP response status code
    # @!attribute [rw] error_code
    #   @return [String] Returns the Adyen code that is mapped to the error message
    # @!attribute [rw] message
    #   @return [String] Returns the message, a short explanation of the issue
    # @!attribute [rw] error_type
    #   @return [String] Returns the type of error that was encountered
    #
    class ServiceException < ApiObject
      attributes :status, :error_code, :message, :error_type, :psp_reference

      validates :status, :error_code, :message, :error_type, presence: true
      validates :error_type, inclusion: { in: %w[internal validation security configuration] }
    end
  end
end
