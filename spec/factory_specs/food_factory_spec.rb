require 'rails_helper'

RSpec.describe 'Food factory' do
  it 'is valid' do
    food = FactoryBot.build(:food)
    expect(food).to be_valid
  end

  it 'has a valid name' do
    food = FactoryBot.build(:food, name: nil)
    expect(food).to_not be_valid
    expect(food.errors[:name]).to include("can't be blank")
  end

  it 'has a valid measurement_unit' do
    food = FactoryBot.build(:food, measurement_unit: nil)
    expect(food).to_not be_valid
    expect(food.errors[:measurement_unit]).to include("can't be blank")
  end

  it 'has a valid quantity' do
    food = FactoryBot.build(:food, quantity: nil)
    expect(food).to_not be_valid
    expect(food.errors[:quantity]).to include("can't be blank")
  end

  it 'has a valid user association' do
    food = FactoryBot.build(:food, user: nil)
    expect(food).to_not be_valid
    expect(food.errors[:user]).to include('must exist')
  end
end
