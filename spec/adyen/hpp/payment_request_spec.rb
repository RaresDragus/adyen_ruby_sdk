require 'spec_helper'

RSpec.describe Adyen::Hpp::PaymentRequest, type: :model do
  it_behaves_like 'a Model with factory', :hpp_payment_request,
                  %i[payment_amount merchant_reference currency_code ship_before_date session_validity shopper_locale
                     country_code shopper_email shopper_reference brand_code]
  it_behaves_like 'a Model with required properties', :hpp_payment_request,
                  %i[merchant_reference payment_amount currency_code ship_before_date session_validity]
end
