class AuthenticateUser
  def initialize(mobile, password=nil, validate_code=nil)
    @mobile = mobile
    @password = password
    @validate_code = validate_code
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :mobile, :password, :validate_code

  def user
    user = User.find_by(mobile: mobile)
    return user if user && password.present? && user.authenticate(password)
    return user if user && validate_code.present? && user.verify_by_code?(validate_code)
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
