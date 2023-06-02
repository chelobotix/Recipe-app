FactoryBot.define do
  factory :food do
    name { Faker::Food.ingredient }
    measurement_unit { Faker::Food.metric_measurement }
    price { Faker::Commerce.price(range: 0..10.0) }
    quantity { Faker::Number.between(from: 1, to: 10) }
    association :user

    transient do
      recipe { nil }
    end

    after(:create) do |food, evaluator|
      if evaluator.recipe
        FactoryBot.create(:recipe_food, food:, recipe: evaluator.recipe, quantity: food.quantity)
      else
        FactoryBot.create(:recipe)
      end
    end
  end
end
