require 'spec_helper'

RSpec.describe Adyen::Common::ServiceException, type: :model do
  it_behaves_like 'a Model with factory', :service_exception, %i[status error_code message error_type]
  it_behaves_like 'a Model with required properties', :service_exception, %i[status error_code message error_type]
  it_behaves_like 'a Model with inclusion validation', :service_exception, :error_type,
                  %w[internal validation security configuration]
end
