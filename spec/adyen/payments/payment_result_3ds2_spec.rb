require 'spec_helper'

RSpec.describe Adyen::Payments::PaymentResult3ds2, type: :model do
  it_behaves_like 'a Model with factory', :payment_result, %i[auth_code psp_reference result_code]
  it_behaves_like 'a Model with required properties', :payment_result, %i[auth_code psp_reference result_code]
  it_behaves_like 'a Model with inclusion validation', :payment_result, :result_code,
                  %w[AuthenticationFinished Authorized Cancelled ChallengeShopper Error IdentifyShopper Pending
                     PresentToShopper Received RedirectShopper Refused]
end
