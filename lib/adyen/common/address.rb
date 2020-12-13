# Namespace module for gem
module Adyen
  # Namespace for basic objects that are used throughout the Adyen API
  module Common
    # Contains detailed information on a physical address
    #
    # @!attribute [rw] city
    #   @return [String] The city name
    # @!attribute [rw] country
    #   @return [String] A valid value is an ISO 2-character country code
    # @!attribute [rw] house_number_or_name
    #   @return [String] The house number or name. Required for US and Canada
    # @!attribute [rw] postal_code
    #   @return [String] The postal code with a maximum of 5 characters for USA and maximum of 10 characters
    #     for any other country
    # @!attribute [rw] state_or_province
    #   @return [String] For USA or Canada, a valid 2-character abbreviation for the state or province respectively.
    #     For other countries any abbreviation with maximum 3 characters for the state or province.
    # @!attribute [rw] street
    #   @return [String] The street name
    #
    class Address < ApiObject
      attributes :city, :country, :street, :house_number_or_name, :postal_code, :state_or_province

      validates :city, :country, :street, presence: true
      validates :country,                 length:   { is: 2 }
      validates :postal_code,             length:   { maximum: 10 }
      validates :state_or_province,       length:   { maximum: 3 }
    end
  end
end
