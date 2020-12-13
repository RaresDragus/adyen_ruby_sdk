require 'spec_helper'

RSpec.describe Adyen::Common::Amount, type: :model do
  it_behaves_like 'a Model with factory', :amount, %i[currency value]
  it_behaves_like 'a Model with required properties', :amount, %i[currency value]
  it_behaves_like 'a Model with fixed length validation', :amount, :currency, 3
  it_behaves_like 'a Model with integer value validation', :amount, :value
end
