require 'rails_helper'

RSpec.describe 'Recipe Factory' do
  it 'creates a valid recipe' do
    recipe = FactoryBot.build(:recipe)
    expect(recipe).to be_valid
  end

  it 'creates a public recipe' do
    recipe = FactoryBot.build(:recipe, public: true)
    expect(recipe.public).to eq(true)
  end

  it 'creates a private recipe' do
    recipe = FactoryBot.build(:recipe, public: false)
    expect(recipe.public).to eq(false)
  end

  it 'has a name' do
    recipe = FactoryBot.build(:recipe, name: nil)
    expect(recipe).to be_invalid
    expect(recipe.errors[:name]).to include("can't be blank")
  end

  it 'has a positive preparation time' do
    recipe = FactoryBot.build(:recipe, preparation_time: -10)
    expect(recipe).to be_invalid
    expect(recipe.errors[:preparation_time]).to include('must be greater than 0')
  end

  it 'has a positive cooking time' do
    recipe = FactoryBot.build(:recipe, cooking_time: 0)
    expect(recipe).to be_invalid
    expect(recipe.errors[:cooking_time]).to include('must be greater than 0')
  end

  it 'is associated with a user' do
    user = FactoryBot.create(:user)
    recipe = FactoryBot.create(:recipe, user:)
    expect(recipe.user).to eq(user)
  end
end
