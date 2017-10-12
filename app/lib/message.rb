class Message
  def self.login_success
    'Login success'
  end

  def self.set_password_successfully
    'Set password successfully'
  end

  def self.not_found(record = 'record')
    "Sorry, #{record} not found"
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.invalid_code
    'Invalid code'
  end

  def self.user_exist
    'User has already exist'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end
end
