FactoryBot.define do
  factory :service_exception, class: Adyen::Common::ServiceException do
    status     { '404' }
    error_code { "Error#{SecureRandom.hex}" }
    message    { "Message#{SecureRandom.hex}" }
    error_type { %w[internal validation security configuration].sample }
  end
end
