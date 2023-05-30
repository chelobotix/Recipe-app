require 'faker'

# Create users
2.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password'
  )
end

# Create foods
30.times do
  Food.create!(
    name: Faker::Food.ingredient,
    measurement_unit: Faker::Boolean.boolean ? 'grams' : 'units',
    price: Faker::Commerce.price(range: 0..10.0),
    quantity: Faker::Number.between(from: 10, to: 100),
    user_id: User.all.sample.id
  )
end

# Create recipes
10.times do
  Recipe.create!(
    name: Faker::Food.dish,
    preparation_time: Faker::Number.between(from: 10, to: 60),
    cooking_time: Faker::Number.between(from: 10, to: 120),
    description: Faker::Lorem.paragraph,
    public: Faker::Boolean.boolean,
    user_id: User.all.sample.id
  )
end

Recipe.all.each do |recipe|
  5.times do
    food_id = Food.all.sample.id
    next unless RecipeFood.where(recipe_id: recipe.id, food_id:).empty?

    RecipeFood.create!(
      quantity: Faker::Number.between(from: 1, to: 10),
      recipe_id: recipe.id,
      food_id:
    )
  end
end
