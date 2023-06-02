require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'is valid with correct parameters' do
    recipe = user.recipes.build(name: 'Pizza', description: 'Delicious pizza', public: true,
                                preparation_time: 10, cooking_time: 20)
    expect(recipe).to be_valid
  end

  it 'is valid with only required parameters' do
    recipe = user.recipes.build(name: 'Pizza', preparation_time: 10, cooking_time: 20)
    expect(recipe).to be_valid
  end

  it 'is invalid without a name' do
    recipe = user.recipes.build(name: nil, description: 'Delicious pizza', public: true,
                                preparation_time: 10, cooking_time: 20)
    expect(recipe).to_not be_valid
  end

  it 'sets public as false by default' do
    recipe = user.recipes.build(name: 'Pizza', description: 'Delicious pizza',
                                preparation_time: 10, cooking_time: 20)
    expect(recipe.public).to be false
  end

  it 'is invalid without a user' do
    recipe = Recipe.new(name: 'Pizza', description: 'Delicious pizza', public: true,
                        preparation_time: 10, cooking_time: 20)
    expect(recipe).to_not be_valid
  end

  describe 'associations' do
    it 'should have many foods through recipe_foods' do
      recipe = Recipe.reflect_on_association(:foods)
      expect(recipe.macro).to eq(:has_many)
      expect(recipe.through_reflection.name).to eq(:recipe_foods)
    end

    it 'should have many recipe_foods' do
      recipe = Recipe.reflect_on_association(:recipe_foods)
      expect(recipe.macro).to eq(:has_many)
    end
  end
end
