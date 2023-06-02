# require 'rails_helper'
# require 'capybara/rspec'

# RSpec.describe 'Users', type: :feature do
#   around(:each) do |example|
#     ActiveRecord::Base.connection.transaction do
#       example.run
#       raise ActiveRecord::Rollback
#     end
#   end

#   describe 'GET /users/sign_up' do
#     context 'can create a user' do
#       it 'displays a list of foods' do
#         visit new_user_registration_path
#         fill_in 'Name', with: 'John Doe'
#         fill_in 'Email', with: 'doe.john@example.com'
#         fill_in 'Password', with: 'password'
#         fill_in 'Password confirmation', with: 'password'
#         click_button 'Sign up'

#         user = User.first
#         puts user.name

#         expect(page).to have_current_path(root_path)
#       end
#     end
#   end
# end

require 'rails_helper'
require 'faker'
require 'cancan'

RSpec.describe 'Index users page', type: :system do
  before do
    @user = User.create(name: Faker::Name.first_name,
                        email: Faker::Internet.email,
                        password: Faker::Internet.password,
                        confirmed_at: "2023-05-29 22:12:54.819467" )

    @recipe = Recipe.create(name: Faker::Food.dish,
      preparation_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 10),
      cooking_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 10),
      description: Faker::Lorem.paragraph,
      public: Faker::Boolean.boolean,
      user: @user)

      visit recipes_path
  end

  describe 'index page' do
    it 'should show the username of all other users' do
      visit recipes_path
      expect(page).to have_content('Coke Chicken')
    end
  end
end
