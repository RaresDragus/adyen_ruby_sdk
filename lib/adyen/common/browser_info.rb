# Namespace module for gem
module Adyen
  # Namespace for basic objects that are used throughout the Adyen API
  module Common
    # Provides fields to hold information on the user browser
    #
    # @!attribute [rw] accept_header
    #   @return [String] The accept header value of the shopper's browser
    # @!attribute [rw] color_depth
    #   @return [Integer] The color depth of the shopper's browser in bits per pixel. This should be obtained by using
    #                     the browser's screen.colorDepth property. Accepted values: 1, 4, 8, 15, 16, 24, 32 or 48 bit
    #                     color depth
    # @!attribute [rw] java_enabled
    #   @return [TrueClass, FalseClass] Boolean value indicating if the shopper's browser is able to execute Java.
    # @!attribute [rw] java_script_enabled
    #   @return [TrueClass, FalseClass] Boolean value indicating if the shopper's browser is able to execute JavaScript.
    #                                   A default 'true' value is assumed if the field is not present.
    # @!attribute [rw] language
    #   @return [String] The navigator.language value of the shopper's browser (as defined in IETF BCP 47).
    # @!attribute [rw] screen_height
    #   @return [Integer] The total height of the shopper's device screen in pixels.
    # @!attribute [rw] screen_width
    #   @return [Integer] The total width of the shopper's device screen in pixels.
    # @!attribute [rw] time_zone_offset
    #   @return [Integer] Time difference between UTC time and the shopper's browser local time, in minutes.
    # @!attribute [rw] user_agent
    #   @return [Integer] The user agent value of the shopper's browser
    #
    class BrowserInfo < ApiObject
      attributes :accept_header, :color_depth, :java_enabled, :java_script_enabled, :language, :screen_height,
                 :screen_width, :time_zone_offset, :user_agent

      validates :accept_header, :color_depth, :language, :screen_height, :screen_width,
                :time_zone_offset, :user_agent, presence: true
    end
  end
end
