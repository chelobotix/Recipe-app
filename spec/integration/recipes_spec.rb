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
      expect(page).to have_content('User: Rodrigo')
    end

  #   it 'should show the profile picture for each user' do
  #     visit users_path
  #     expect(page).to have_selector('img[src="https://randomuser.me/api/portraits/men/31.jpg"]')
  #   end

  #   it 'should show the number of posts each user has written' do
  #     visit users_path
  #     expect(page).to have_content('Number of posts: 1')
  #   end

  #   it 'should redirected to specific users show page' do
  #     visit users_path
  #     page.all(:link, 'picture_link').last.click
  #     expect(page).to have_current_path('/users/10')
  #   end
  end
end
