require 'spec_helper'

RSpec.describe Adyen::Payments::BankAccount, type: :model do
  it_behaves_like 'a Model with factory', :bank_account,
                  %i[bank_account_number bank_city bank_location_id bank_name bic country_code iban owner_name tax_id]
  it_behaves_like 'a Model with required properties', :bank_account,
                  %i[bank_account_number bank_name country_code iban owner_name]
  it_behaves_like 'a Model with fixed length validation', :bank_account, :country_code, 2
end
