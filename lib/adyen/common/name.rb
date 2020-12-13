# Namespace module for gem
module Adyen
  # Namespace for basic objects that are used throughout the Adyen API
  module Common
    # Provides the fields to hold structured information on a person's name and gender
    #
    # @!attribute [rw] first_name
    #   @return [String] A person's first name
    # @!attribute [rw] gender
    #   @return [String] A person's gender
    # @!attribute [rw] infix
    #   @return [String] A person name's infix, if applicable
    # @!attribute [rw] last_name
    #   @return [String] A person's last name
    #
    class Name < ApiObject
      attributes :first_name, :last_name, :gender, :infix

      validates :first_name, :last_name, :gender, presence:  true
      validates :gender,                          inclusion: { in: %w[MALE FEMALE UNKNOWN] }
      validates :infix,                           length:    { maximum: 20 }
    end
  end
end
