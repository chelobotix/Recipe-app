require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  describe 'GET #index' do
    it 'returns a list of foods' do
      user = FactoryBot.create(:user)
      user.confirm
      sign_in user

      foods = FactoryBot.create_list(:food, 5, user:)

      get :index

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('text/html')

      foods.each do |food|
        expect(foods).to include(food)
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new food' do
      user = FactoryBot.create(:user)
      user.confirm
      sign_in user

      food_params = { name: 'Apple', quantity: 10, measurement_unit: 'pieces', price: 2.99, user_id: user.id }

      post :create, params: { food: food_params }

      expect(Food.count).to eq(1)
      food = Food.last
      expect(food.name).to eq('Apple')
      expect(food.quantity).to eq(10)
      expect(food.measurement_unit).to eq('pieces')
      expect(food.price).to eq(2.99)
      expect(food.user).to eq(user)
    end
  end
end
