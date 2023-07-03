RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must be created with password and password_confirmation fields' do
      user = User.new(password: 'password', password_confirmation: 'password')
      expect(user.valid?).to be true
    end

    it 'should not be valid if password and password_confirmation do not match' do
      user = User.new(password: 'password1', password_confirmation: 'password2')
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should require password and password_confirmation' do
      user = User.new
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
    end

    it 'should validate uniqueness of email (case-insensitive)' do
      User.create(email: 'test@test.com')
      user = User.new(email: 'TEST@TEST.com')
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should require email, first name, and last name' do
      user = User.new
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Email can't be blank", "First name can't be blank", "Last name can't be blank")
    end

    it 'should have a minimum password length' do
      user = User.new(password: 'pass', password_confirmation: 'pass')
      expect(user.valid?).to be false
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return user if authenticated successfully' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should return nil if authentication fails' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'should ignore leading and trailing spaces in the email' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'should ignore case sensitivity in the email' do
      user = User.create(email: 'test@test.com', password: 'password')
      authenticated_user = User.authenticate_with_credentials('TeSt@tEsT.com', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
