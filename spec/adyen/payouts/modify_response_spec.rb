require 'spec_helper'

RSpec.describe Adyen::Payouts::ModifyResponse, type: :model do
  it_behaves_like 'a Model with factory', :modify_response, %i[psp_reference response]
  it_behaves_like 'a Model with required properties', :modify_response, %i[psp_reference response]
end
