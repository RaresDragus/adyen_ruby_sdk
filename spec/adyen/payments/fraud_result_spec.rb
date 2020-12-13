require 'spec_helper'

RSpec.describe Adyen::Payments::FraudResult, type: :model do
  it_behaves_like 'a Model with factory', :fraud_check_result, %i[account_score]
  it_behaves_like 'a Model with required properties', :fraud_check_result, %i[account_score]
  it_behaves_like 'a Model with integer value validation', :fraud_check_result, :account_score
end
