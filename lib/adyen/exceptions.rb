# Namespace module for gem
module Adyen
  # Namespace module for custom Exceptions
  module Exceptions
    class InvalidApiObject < StandardError
    end

    class Timeout < StandardError
    end
  end
end
