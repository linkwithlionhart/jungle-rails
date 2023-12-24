require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    # Example 1: Ensure a user is valid with valid attributes.
    it 'is valid with valid attributes' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      expect(user).to be_valid
    end

    # Example 2: Validate presence of password and password_confirmation.
    it 'is not valid without matching password and password_confirmation' do
      user = User.new(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'differentpassword',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password.")
    end

    # Example 3: Validate presence of email, first name, and last name.
    it 'is not valid without required fields' do
      user = User.new
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank.", "Password can't be blank.", "First name can't be blank.", "Last name can't be blank.")
    end

    # Example 4: Validate uniqueness of email (case-insensitive).
    it 'is not valid with a non-unique email' do
      User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      user = User.new(
        email: 'TEST@example.com',
        password: 'differentpassword',
        password_confirmation: 'differentpassword',
        first_name: 'Jane',
        last_name: 'Doe'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken.")
    end

    # Example 5: Validate minimum length of the password.
    it "is not valid with a password less than the minimum length" do 
      user = User.new(
        email: 'test@example.com',
        password: 'short',
        password_confirmation: 'short',
        first_name: 'John',
        last_name: 'Doe'
      )
      user.valid?
      expect(user.errors.full_messages).to include("Password is too short. Minimum is 12 characters.")
    end
  end # 1st describe block

  describe '.authenticate_with_credentials' do
    # Example 1: Authenticate user with correct credentials.
    it 'returns the user instance for valid credentials' do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    # Example 2: Authenticate user with incorrect email.
    it 'returns nil for incorrect email' do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('wrong@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    # Example 3: Authenticate user with incorrect password.
    it 'returns nil for incorrect password' do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    # Example 4: Authenticate user with leading/trailing spaces in email.
    it 'ignores leading/trailing spaces in email' do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    # Example 5: Authenticate user with case-insensitive email.
    it 'ignores case in email' do
      user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )

      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end # 2nd describe block

end # outer-most
