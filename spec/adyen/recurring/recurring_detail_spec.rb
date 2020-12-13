require 'spec_helper'

RSpec.describe Adyen::Recurring::RecurringDetail, type: :model do
  it_behaves_like 'a Model with factory', :recurring_detail,
                  %i[card_number_alias alias_type creation_date first_psp_reference recurring_detail_reference variant]
  it_behaves_like 'a Model with required properties', :recurring_detail,
                  %i[alias_type creation_date first_psp_reference recurring_detail_reference variant]
end
