# Namespace module for gem
module Adyen
  # Namespace for payments objects that are used throughout the Adyen API
  module Common
    # A container for a specific item.
    #
    # @!attribute [rw] item_ID
    #   @return [String] ID of the item.
    # @!attribute [rw] product_title
    #   @return [String] A text description of the product the invoice line refers to.
    # @!attribute [rw] amount_per_item
    #   @return [String] The price of item<itemNr> in the basket, represented in minor units.
    # @!attribute [rw] currency
    #   @return [String] The three-character ISO currency code.
    # @!attribute [rw] upc
    #   @return [String] Universal Product Code.
    # @!attribute [rw] sku
    #   @return [String] Stock keeping unit.
    # @!attribute [rw] brand
    #   @return [String] Brand of the item.
    # @!attribute [rw] manufacturer
    #   @return [String] Manufacturer of the item.
    # @!attribute [rw] category
    #   @return [String] Category of the item.
    # @!attribute [rw] color
    #   @return [String] Color of the item.
    # @!attribute [rw] size
    #   @return [String] Size of the item.
    # @!attribute [rw] quantity
    #   @return [String] Quantity of the item purchased.
    #
    class Item < ApiObject
      attributes :item_ID, :product_title, :amount_per_item, :currency, :upc, :sku, :brand, :manufacturer, :category,
                 :color, :size, :quantity
    end
  end
end
