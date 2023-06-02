FactoryBot.define do
  factory :recipe_food do
    quantity { Faker::Number.between(from: 1, to: 10) }
    association :recipe
    association :food
  end
end
