require 'rails_helper'

RSpec.describe 'User Factory' do
  it 'creates a valid user' do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it 'has a name' do
    user = FactoryBot.build(:user, name: nil)
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'has an email' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to be_invalid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'has a password' do
    user = FactoryBot.build(:user, password: nil)
    expect(user).to be_invalid
    expect(user.errors[:password]).to include("can't be blank")
  end
end
