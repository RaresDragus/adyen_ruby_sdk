require 'spec_helper'

RSpec.describe Adyen::Recurring::RecurringDetailsResult, type: :model do
  it_behaves_like 'a Model with factory', :recurring_details_result, %i[creation_date details shopper_reference]
  it_behaves_like 'a Model with required properties', :recurring_details_result,
                  %i[creation_date details shopper_reference]
end
