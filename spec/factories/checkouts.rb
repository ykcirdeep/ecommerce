FactoryBot.define do
  factory :checkout do
    association :user
    association :product
    price { 0 }
    discount { 0 }
    quantity { 1 }
  end
end
