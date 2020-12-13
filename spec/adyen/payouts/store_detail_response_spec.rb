require 'spec_helper'

RSpec.describe Adyen::Payouts::StoreDetailResponse, type: :model do
  it_behaves_like 'a Model with factory', :store_detail_response,
                  %i[psp_reference result_code recurring_detail_reference]
  it_behaves_like 'a Model with required properties', :store_detail_response,
                  %i[psp_reference result_code recurring_detail_reference]
end
