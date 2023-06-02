require 'rails_helper'
require 'faker'
require 'cancan'

RSpec.describe 'Recipe#Users', type: :system do
  let(:user) do
    FactoryBot.create(:user)
  end

  let(:food) do
    Food.create(name: 'Tomato', quantity: 1, measurement_unit: 'units', price: 5, user:)
  end

  let(:recipe) do
    FactoryBot.create(:recipe, name: 'Chicken', user:)
  end

  before do
    user.confirm
    sign_in user
  end

  xdescribe 'index page' do
    it 'has the user created recipe' do
      visit recipes_path
      expect(page).to have_content('Chicken')
    end

    it 'has button to create a new recipe' do
      visit recipes_path
      expect(page).to have_link('New recipe')
    end
  end

  xdescribe 'Recipes#Show' do
    it 'has the Add Ingredient button' do
      visit recipe_path(recipe.id)
      expect(page).to have_content('Add ingredient')
    end

    it 'has the Generate Shopping List button' do
      visit recipe_path(recipe.id)
      expect(page).to have_content('Generate shopping list')
    end

    it 'has the Back to recipes button' do
      visit recipe_path(recipe.id)
      expect(page).to have_content('Back to recipes')
    end
  end

  xdescribe 'Recipes#New' do
    before do
      visit new_recipe_path
    end

    it 'has the input fields' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Preparation time (hours)')
      expect(page).to have_field('Cooking time (hours)')
      expect(page).to have_field('Description')
    end
  end

  xdescribe 'Recipes#Create' do
    before do
      visit new_recipe_path
    end

    it 'creates a new recipe' do
      fill_in 'Name', with: 'Chicken'
      fill_in 'Preparation time (hours)', with: 1
      fill_in 'Cooking time (hours)', with: 1
      fill_in 'Description', with: 'Chicken'
      click_button 'Create Recipe'

      expect(page).to have_content('Recipe was successfully created.')
    end
  end

  describe 'Recipes#AddIngredient' do
    before do
      visit recipes_add_ingredient_path(recipe.id)
      puts "~~~~~~~DEBUGGIN LOG: #{user.id}"
      puts "~~~~~~~DEBUGGIN LOG: #{food.user.id}"
      puts "~~~~~~~DEBUGGIN LOG: #{recipe.user.id}"
      puts "~~~~~~~DEBUGGIN LOG: #{recipe.id}"

    end

    xit 'has the input fields' do
      expect(page).to have_selector('select')
      expect(page).to have_selector('input')
    end

    it 'Add ingredient to recipe' do
      select 'Tomato', from: 'Ingredient'
      fill_in 'Quantity', with: 1
      click_button 'Add ingredient'

      expect(page).to have_content('Ingredient was successfully added.')
    end
  end

end
