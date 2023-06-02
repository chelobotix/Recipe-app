require 'rails_helper'
require 'cancan'

RSpec.describe 'ShoppingLists', type: :request do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  describe 'GET /index' do
    it 'returns the shopping list' do
      user = FactoryBot.create(:user)
      user.confirm
      sign_in user

      # Create some foods with specific quantities
      foods = FactoryBot.create_list(:food, 5, user:, quantity: 5)

      # Create a recipe with associated foods and a quantity greater than available quantity
      recipe = FactoryBot.create(:recipe, user:)
      foods.each do |food|
        FactoryBot.create(:recipe_food, recipe:, food:, quantity: food.quantity + 1)
      end

      get '/shopping_list'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('text/html')

      foods.each do |food|
        expect(response.body).to include(food.name)
        expect(response.body).to include('1')
        expect(response.body).to include(food.measurement_unit)
        expect(response.body).to include(food.price.to_s)
      end
    end
  end
end
