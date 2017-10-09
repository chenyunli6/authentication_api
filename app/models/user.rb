class User < ApplicationRecord

  has_secure_password

  validates_presence_of :mobile, :validate_code, :password_digest
end
