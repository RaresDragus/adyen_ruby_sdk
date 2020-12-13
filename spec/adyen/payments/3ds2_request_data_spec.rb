require 'spec_helper'

RSpec.describe Adyen::Payments::BankAccount, type: :model do
  it_behaves_like 'a Model with factory',             :threeds2_request_data, %i[device_channel notification_URL]
  it_behaves_like 'a Model with required properties', :threeds2_request_data, %i[device_channel]
end
