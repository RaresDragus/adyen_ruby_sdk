require 'spec_helper'

RSpec.describe Adyen::Common::Promotion, type: :model do
  it_behaves_like 'a Model with factory', :promotion,
                  %i[promotion_code promotion_name promotion_discount_amount promotion_discount_currency]
end
