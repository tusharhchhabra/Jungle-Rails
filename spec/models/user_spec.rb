require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'should be valid with valid attributes' do
      user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'password', name: 'John Doe')
      expect(user).to be_valid
    end

    it 'should not be valid without matching password and password_confirmation' do
      user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'wrong_password', name: 'John Doe')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not be valid without a unique email' do
      User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', name: 'John Doe')
      user = User.new(email: 'test@test.com', password: 'password', password_confirmation: 'password', name: 'Jane Doe')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not be valid without email and name' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank", "Name can't be blank")
    end

    it 'should not be valid with a short password' do
      user = User.new(email: 'test@test.com', password: 'abc', password_confirmation: 'abc', name: 'John Doe')
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before :each do
      @user = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password', name: 'John Doe')
    end

    it 'should authenticate with correct credentials' do
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'should not authenticate with incorrect credentials' do
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    it 'should authenticate even with spaces around email' do
      authenticated_user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(authenticated_user).to eq(@user)
    end

    it 'should authenticate even with wrong email case' do
      authenticated_user = User.authenticate_with_credentials('TEST@TEST.COM', 'password')
      expect(authenticated_user).to eq(@user)
    end
  end

end
