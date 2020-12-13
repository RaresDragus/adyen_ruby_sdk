require 'spec_helper'

RSpec.describe Adyen::Payouts::StoreDetailAndSubmitResponse, type: :model do
  it_behaves_like 'a Model with factory', :store_detail_and_submit_response, %i[psp_reference result_code]
  it_behaves_like 'a Model with required properties', :store_detail_and_submit_response, %i[psp_reference result_code]
end
