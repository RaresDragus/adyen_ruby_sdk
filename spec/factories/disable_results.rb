FactoryBot.define do
  factory :disable_result, class: Adyen::Recurring::DisableResult do
    response { %w[[detail-successfully-disabled] [all-details-successfully-disabled]].sample }
  end
end
