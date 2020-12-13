require 'adyen_cse'
require 'base64'
require 'json'
require 'logger'
require 'ostruct'
require 'restclient'
require 'singleton'

require 'active_support/configurable'
require 'active_model'

# Namespace module for gem
module Adyen
  require 'adyen/version'
  require 'adyen/exceptions'
  require 'adyen/connection'
  require 'adyen/api_object'
  require 'adyen/api_request'
  require 'adyen/payment_api_request'
  require 'adyen/recurring_api_request'
  require 'adyen/payout_api_request'

  %w[common hpp payments payouts recurring].each do |sub_dir|
    Dir[File.join(File.dirname(__FILE__), 'adyen/' + sub_dir, '**', '*.rb')].each { |f| require f }
  end

  # @return [Logger] Logger that the library should use
  def self.log
    @log ||= Logger.new('/dev/null')
    @log
  end

  # @return [Logger] Sets up the Logger that the library should use
  # @param [Logger] rlogger The logger to use
  def self.log=(rlogger)
    @log = rlogger
  end
end
