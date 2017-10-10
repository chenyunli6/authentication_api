class User < ApplicationRecord

  has_secure_password

  validates_presence_of :mobile, :validate_code, :password_digest

  def verify_by_code?(code)
    code == '123456'
  end
end
