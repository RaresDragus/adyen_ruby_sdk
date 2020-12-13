require 'spec_helper'

RSpec.describe Adyen::Payments::ModificationResult, type: :model do
  it_behaves_like 'a Model with factory', :modification_result, %i[psp_reference response]
  it_behaves_like 'a Model with required properties', :modification_result, %i[psp_reference response]
  it_behaves_like 'a Model with fixed length validation', :modification_result, :psp_reference, 16
end
