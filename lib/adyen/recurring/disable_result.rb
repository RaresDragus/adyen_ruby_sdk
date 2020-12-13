# Namespace module for gem
module Adyen
  # Namespace for recurring objects that are used throughout the Adyen API
  module Recurring
    # Contains data that is returned as a response to a /disable request.
    #
    # @!attribute [rw] response
    #   @return [String] Depending on whether a specific recurring detail was in the request,
    #     result is either "[detail-successfully-disabled]" or "[all-details-successfully-disabled]".
    #
    class DisableResult < ApiObject
      attributes :response

      validates :response, presence:  true,
                           inclusion: { in: %w[[detail-successfully-disabled] [all-details-successfully-disabled]] }
    end
  end
end
