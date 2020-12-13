require 'spec_helper'

RSpec.describe Adyen::Common::Name, type: :model do
  it_behaves_like 'a Model with factory', :name, %i[first_name last_name gender infix]
  it_behaves_like 'a Model with required properties', :name, %i[first_name last_name gender]
  it_behaves_like 'a Model with maximum length validation', :name, :infix, 20
  it_behaves_like 'a Model with inclusion validation', :name, :gender, %w[MALE FEMALE UNKNOWN]
end
