require 'adyen'
require 'yaml'
require 'logger'

logger =   defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
env_name = defined?(Rails) ? Rails.env : ENV['RAILS_ENV'] || ENV['RACK_ENV'] || ENV['ADYEN_ENV'] || 'development'

Adyen::Connection.configure do |config|
  yml_config = YAML.load_file(
    File.expand_path(File.join('..', 'adyen.yml'), File.dirname(__FILE__))
  )[env_name]
  yml_config.each do |key, value|
    config.send("#{key}=", value)
  end
end

Adyen.log      = logger
RestClient.log = logger
