require 'rails_helper'
require 'cancan'

RSpec.describe 'Recipes', type: :request do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  let(:user) do
    FactoryBot.create(:user)
  end

  describe 'GET /recipes' do
    it 'returns a list of recipes' do
      user.confirm
      sign_in user
      recipes = FactoryBot.create_list(:recipe, 5, user:)

      get '/recipes'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('text/html')

      recipes.each do |recipe|
        expect(response.body).to include(recipe.name)
      end
    end
  end

  describe 'GET /recipes/:id' do
    it 'returns a single recipe' do
      user.confirm
      sign_in user
      recipe = FactoryBot.create(:recipe, user:)

      get "/recipes/#{recipe.id}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('text/html')

      expect(response.body).to include(recipe.name)
    end
  end

  describe 'POST /recipes' do
    it 'creates a new recipe with current_user as owner' do
      user.confirm
      sign_in user

      recipe_params = {
        name: 'Chocolate Cake',
        preparation_time: 30,
        cooking_time: 60,
        description: 'Delicious chocolate cake recipe'
      }

      post '/recipes', params: { recipe: recipe_params }

      expect(response).to have_http_status(:found)

      follow_redirect!

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('text/html')

      expect(response.body).to include('Chocolate Cake')
      expect(response.body).to include('30')
      expect(response.body).to include('60')
      expect(response.body).to include('Delicious chocolate cake recipe')

      recipe = Recipe.last
      expect(recipe.user).to eq(user)
    end
  end

  describe 'DELETE /recipes/:id' do
    it 'deletes a recipe' do
      user = FactoryBot.create(:user)
      recipe = FactoryBot.create(:recipe, user:)

      sign_in user

      delete "/recipes/#{recipe.id}"

      expect(response).to have_http_status(:found)

      follow_redirect!

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('text/html')

      expect(response.body).to_not include(recipe.name)
      expect(response.body).to_not include(recipe.description)
    end
  end
end
