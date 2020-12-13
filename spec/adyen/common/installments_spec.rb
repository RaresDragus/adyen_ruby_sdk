require 'spec_helper'

RSpec.describe Adyen::Common::Installments, type: :model do
  it_behaves_like 'a Model with factory', :installments, %i[value]
  it_behaves_like 'a Model with required properties', :installments, %i[value]
  it_behaves_like 'a Model with integer value validation', :installments, :value
end
