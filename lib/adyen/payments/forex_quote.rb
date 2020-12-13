# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Payments
    # Holds information on the forex quote as returned in the response of the forex service
    #
    # @!attribute [rw] account
    #   @return [String] The account name
    # @!attribute [rw] account_type
    #   @return [String] The account type
    # @!attribute [rw] base_amount
    #   @return [Hash] The base amount
    # @!attribute [rw] base_points
    #   @return [Integer] The base points
    # @!attribute [rw] buy
    #   @return [Hash] The buy rate
    # @!attribute [rw] interbank
    #   @return [Hash] The interbank amount
    # @!attribute [rw] reference
    #   @return [String] The reference assigned to the forex quote request
    # @!attribute [rw] sell
    #   @return [Hash] The sell rate
    # @!attribute [rw] signature
    #   @return [String] The signature to validate the integrity
    # @!attribute [rw] source
    #   @return [String] The source of the forex quote
    # @!attribute [rw] type
    #   @return [String] The type of forex
    # @!attribute [rw] valid_till
    #   @return [DateTime] The date until which the forex quote is valid
    #
    class ForexQuote < ApiObject
      attributes :account, :account_type, :base_amount, :base_points, :buy, :interbank, :reference, :sell,
                 :signature, :source, :type, :valid_till

      validates :base_points, :valid_till, presence: true
      validates :base_points, numericality: { only_integer: true }
    end
  end
end
