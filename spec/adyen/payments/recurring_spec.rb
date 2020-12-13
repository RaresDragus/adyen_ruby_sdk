require 'spec_helper'

RSpec.describe Adyen::Payments::Recurring, type: :model do
  it_behaves_like 'a Model with factory', :recurring, %i[contract]
  it_behaves_like 'a Model with required properties', :recurring, %i[contract]
  it_behaves_like 'a Model with inclusion validation', :recurring, :contract,
                  %w[ONECLICK RECURRING RECURRING,ONECLICK]
end
