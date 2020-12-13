require 'spec_helper'

RSpec.describe Adyen::Payments::ForexQuote, type: :model do
  it_behaves_like 'a Model with factory', :forex_quote, %i[base_points valid_till]
  it_behaves_like 'a Model with required properties', :forex_quote, %i[base_points valid_till]
  it_behaves_like 'a Model with integer value validation', :forex_quote, :base_points
end
