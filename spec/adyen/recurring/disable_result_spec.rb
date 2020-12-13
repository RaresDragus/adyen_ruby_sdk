require 'spec_helper'

RSpec.describe Adyen::Recurring::DisableResult, type: :model do
  it_behaves_like 'a Model with factory', :disable_result, %i[response]
  it_behaves_like 'a Model with required properties', :disable_result, %i[response]
  it_behaves_like 'a Model with inclusion validation', :disable_result, :response,
                  %w[[detail-successfully-disabled] [all-details-successfully-disabled]]
end
