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
    Recipe.create(name: "Pineapple Chicken", preparation_time: 1, cooking_time: 2, description: "dasdasdas", public: true, user: user)
  end

  before do
    user.confirm
    sign_in user
  end

  describe 'index page' do
    it 'has the user created recipe' do
      @user1 = User.create(name: 'Fede', email: 'fedefede@railsmail.com', password: '111111')

      @user1.confirm
      sign_in @user1

      @recipe1 = Recipe.create(name: "Pineapple Chicken", preparation_time: 1, cooking_time: 2, description: "dasdasdas", public: true, user: @user1)
      visit recipes_path
      expect(page).to have_content('Pineapple Chicken')
    end

    it 'has button to create a new recipe' do
      visit recipes_path
      expect(page).to have_link('New recipe')
    end
  end

  describe 'Recipes#Show' do
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

  describe 'Recipes#New' do
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

  describe 'Recipes#Create' do
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
      @user1 = User.create(name: 'Fede', email: 'fedefede@railsmail.com', password: '111111')

      @user1.confirm
      sign_in @user1

      @recipe1 = Recipe.create(name: "Coke Pork", preparation_time: 1, cooking_time: 2, description: "dasdasdas", public: true, user: @user1)

      @food1 = Food.create(name: 'Jam', measurement_unit: 'unit', price: 12, quantity: 10, user: @user1)
      visit recipes_add_ingredient_path(id: @recipe1.id)
    end

    it 'has the input fields' do
      expect(page).to have_selector('select')
      expect(page).to have_selector('input')
    end

    it 'Add ingredient to recipe' do
      fill_in 'recipe_food[quantity]', with: 2
      click_button 'Add Ingredient'

      expect(page).to have_content('Ingredient was successfully added.')
    end
  end

end
