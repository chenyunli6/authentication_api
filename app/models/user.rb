class User < ApplicationRecord

  has_secure_password :validations => false

  validates_presence_of :mobile, :validate_code

  def verify_by_code?(code)
    code == '123456'
  end
end
