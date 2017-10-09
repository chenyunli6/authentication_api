class User < ApplicationRecord
  validates_presence_of :mobile, :validate_code, :password_digest
end
