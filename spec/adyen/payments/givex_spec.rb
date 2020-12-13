require 'spec_helper'

RSpec.describe Adyen::Payments::Givex, type: :model do
  it_behaves_like 'a Model with factory', :givex, %i[expiry_month expiry_year holder_name number]
  it_behaves_like 'a Model with required properties', :givex, %i[expiry_month expiry_year holder_name number]
  it_behaves_like 'a Model with fixed length validation', :givex, :expiry_month, 2
  it_behaves_like 'a Model with fixed length validation', :givex, :expiry_year, 4
  it_behaves_like 'a Model with range length validation', :card, :number, 4, 19
end
