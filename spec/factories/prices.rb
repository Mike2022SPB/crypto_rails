FactoryBot.define do
  factory :price do
    value { 1000.0 }
    date { 1.day.ago }
    association :currency
  end
end
