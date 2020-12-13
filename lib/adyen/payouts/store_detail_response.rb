# Namespace module for gem
module Adyen
  # Namespace for payouts objects that are used throughout the Adyen API
  module Payouts
    # Contains data that should be received from the /storeDetail
    #
    # @!attribute [rw] additional_data
    #   @return [Hash] This field contains additional data, which may be returned in a particular response.
    # @!attribute [rw] psp_reference
    #   @return [String] A new reference to uniquely identify this request
    # @!attribute [rw] result_code
    #   @return [String] The result code of the transaction. Success indicates that the details were stored successfully
    # @!attribute [rw] recurring_detail_reference
    #   @return [String] The token which you can use later on for submitting the payout.
    #
    class StoreDetailResponse < ApiObject
      attributes :additional_data, :psp_reference, :result_code, :recurring_detail_reference

      validates :psp_reference, :result_code, :recurring_detail_reference, presence: true
    end
  end
end
