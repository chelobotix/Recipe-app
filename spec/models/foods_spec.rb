require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with correct parameters' do
    food = user.foods.build(name: 'Pizza', measurement_unit: 'kg', price: 10.0, quantity: 1)
    expect(food).to be_valid
  end

  it 'is valid with only required parameters' do
    food = user.foods.build(name: 'Pizza', measurement_unit: 'kg', quantity: 1)
    expect(food).to be_valid
  end

  it 'is invalid without a user' do
    food = Food.new(name: 'Pizza', measurement_unit: 'kg', price: 10.0, quantity: 1)
    expect(food).to_not be_valid
  end

  it 'is invalid without a name' do
    food = user.foods.build(name: nil, measurement_unit: 'kg', price: 10.0, quantity: 1)
    expect(food).to_not be_valid
  end

  it 'is invalid without a measurement_unit' do
    food = user.foods.build(name: 'Pizza', measurement_unit: nil, price: 10.0, quantity: 1)
    expect(food).to_not be_valid
  end

  describe 'associations' do
    it 'should have many recipes through recipe_foods' do
      food = Food.reflect_on_association(:recipes)
      expect(food.macro).to eq(:has_many)
      expect(food.through_reflection.name).to eq(:recipe_foods)
    end

    it 'should have many recipe_foods' do
      food = Food.reflect_on_association(:recipe_foods)
      expect(food.macro).to eq(:has_many)
    end
  end
end
