require 'spec_helper'

RSpec.describe Adyen::Common::Item, type: :model do
  it_behaves_like 'a Model with factory', :item,
                  %i[item_ID product_title amount_per_item currency upc sku brand manufacturer category color size
                     quantity]
end
