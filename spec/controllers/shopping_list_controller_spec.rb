require 'rails_helper'

describe ShoppingListController, type: :controller do
  describe 'GET #Index' do
    it 'returns the shopping list for the current user' do

      # user = FactoryBot.create(:user)
      # user.confirm
      # sign_in user

      # # Create some foods with specific quantities
      # foods = FactoryBot.create_list(:food, 5, user:, quantity: 5)

      # # Create a recipe with associated foods and a quantity greater than available quantity
      # recipe = FactoryBot.create(:recipe, user:)
      # foods.each do |food|
      #   FactoryBot.create(:recipe_food, recipe:, food:, quantity: food.quantity + 1)
      # end

      # get '/shopping_list'



      # Create a user and foods associated with the user
      user = FactoryBot.create(:user)
      user.confirm
      sign_in user
      foods = FactoryBot.create_list(:food, 5, user:, quantity: 5)

      recipe = FactoryBot.create(:recipe, user:)
      foods.each do |food|
        FactoryBot.create(:recipe_food, recipe:, food:, quantity: food.quantity + 1)
      end

      # Make a GET request to the shopping_list action
      get :index

      # Assert the response
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('text/html')

      # Assert the content of the response
      foods.each do |food|
        expect(assigns(:missing_foods).map(&:food)).to include(food)
        expect(assigns(:missing_foods).find { |mf| mf.food == food }.instance_variable_get(:@missing_quantity)).to eq(1)
      end

    end

    it 'redirects to the login page for anonymous users' do
      get :index

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
