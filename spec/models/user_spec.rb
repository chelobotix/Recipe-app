require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with correct parameters' do
    user = User.new(name: 'John Doe', email: 'doe.john@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil, email: 'doe.john@example.com', password: 'password')
    expect(user).to_not be_valid
  end

  it 'is invalid without a email' do
    user = User.new(name: nil, email: nil, password: 'password')
    expect(user).to_not be_valid
  end

  it 'is invalid without a password' do
    user = User.new(name: nil, email: 'doe.john@example.com', password: nil)
    expect(user).to_not be_valid
  end
end
