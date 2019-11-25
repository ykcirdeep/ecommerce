FactoryBot.define do
  factory :discount do
    association :product
    discount_type { 0 }
    discount_value { 5 }
  end
end
