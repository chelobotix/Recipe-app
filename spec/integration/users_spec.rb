require 'rails_helper'
require 'capybara/rspec'

RSpec.describe 'Users', type: :feature do
  around(:each) do |example|
    ActiveRecord::Base.connection.transaction do
      example.run
      raise ActiveRecord::Rollback
    end
  end

  describe 'GET /users/sign_up' do
    context 'can create a user' do
      it 'displays a list of foods' do
        visit new_user_registration_path
        fill_in 'Name', with: 'John Doe'
        fill_in 'Email', with: 'doe.john@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign up'

        user = User.first
        puts user.name

        expect(page).to have_current_path(root_path)
      end
    end
  end
end
