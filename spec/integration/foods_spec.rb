require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Foods', type: :feature do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  describe 'GET /foods' do
    context 'when user is logged in' do
      it 'displays a list of foods' do
        user = FactoryBot.create(:user)
        foods = FactoryBot.create_list(:food, 5, user:)
        # user.confirm

        puts current_path
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'

        expect(page).to have_content('You have to confirm your email address before continuing.')
        # expect(page).to have_current_path(root_path)
        # expect(page).to have_content('Signed in successfully.')

        visit foods_path

        expect(page).to have_http_status(:ok)
        expect(page).to have_content('Foods')

        foods.each do |food|
          expect(page).to have_content(food.name)
          expect(page).to have_content("#{food.quantity} #{food.measurement_unit}")
          expect(page).to have_content(food.price.to_s)
        end
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
