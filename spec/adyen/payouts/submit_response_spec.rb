require 'spec_helper'

RSpec.describe Adyen::Payouts::SubmitResponse, type: :model do
  it_behaves_like 'a Model with factory', :submit_response, %i[psp_reference result_code refusal_reason]
  it_behaves_like 'a Model with required properties', :submit_response, %i[psp_reference result_code]
end
