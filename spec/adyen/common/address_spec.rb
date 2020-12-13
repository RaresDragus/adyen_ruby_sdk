require 'spec_helper'

RSpec.describe Adyen::Common::Address, type: :model do
  it_behaves_like 'a Model with factory', :address,
                  %i[city country street house_number_or_name postal_code state_or_province]
  it_behaves_like 'a Model with required properties', :address, %i[city country street]
  it_behaves_like 'a Model with fixed length validation', :address, :country, 2
  it_behaves_like 'a Model with maximum length validation', :address, :postal_code, 10
  it_behaves_like 'a Model with maximum length validation', :address, :state_or_province, 3
end
