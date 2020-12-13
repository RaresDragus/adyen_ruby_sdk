# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Common
    # A container for a specific promotion.
    #
    # @!attribute [rw] promotion_code
    #   @return [String] Code of the promotion.
    # @!attribute [rw] promotion_name
    #   @return [String] Name of the promotion.
    # @!attribute [rw] promotion_discount_amount
    #   @return [String] The discount amount of the promotion, represented in minor units.
    # @!attribute [rw] promotion_discount_currency
    #   @return [String] The three-character ISO currency code.
    # @!attribute [rw] promotion_discount_percentage
    #   @return [String] Promotion's percentage discount. It is represented in percentage value and there is no need
    #     to include the '%' sign. e.g. for a promotion discount of 30%, the value of the field should be 30.
    #
    class Promotion < ApiObject
      attributes :promotion_code, :promotion_name, :promotion_discount_amount, :promotion_discount_currency,
                 :promotion_discount_percentage
    end
  end
end
