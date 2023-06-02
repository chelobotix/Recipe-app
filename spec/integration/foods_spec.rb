require 'rails_helper'
require 'faker'
require 'cancan'

RSpec.describe 'Foods', type: :system do
  describe 'GET /foods' do
    context 'when user is logged in' do
      it 'displays a list of foods' do
        user = FactoryBot.create(:user)
        foods = FactoryBot.create_list(:food, 5, user:)
        user.confirm

        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_current_path(root_path)
        expect(page).to have_content('Signed in successfully.')

        visit foods_path

        expect(page).to have_content('Foods')

        foods.each do |food|
          expect(page).to have_content(food.name)
          expect(page).to have_content("#{food.quantity} #{food.measurement_unit}")
          expect(page).to have_content(food.price.to_s)
        end
      end
    end

    context 'when user is logged in but has no foods' do
      it 'it can create a new food' do
        user = FactoryBot.create(:user)
        user.confirm

        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_current_path(root_path)
        expect(page).to have_content('Signed in successfully.')

        visit foods_path

        click_link 'New food'

        fill_in 'Name', with: Faker::Food.dish
        fill_in 'Quantity', with: Faker::Number.between(from: 1, to: 100)
        fill_in 'Measurement unit', with: Faker::Food.metric_measurement
        fill_in 'Price', with: Faker::Number.between(from: 1, to: 100)
        click_button 'Create Food'
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        visit foods_path

        expect(page).to have_current_path(new_user_session_path)
      end
    end
  end
end
