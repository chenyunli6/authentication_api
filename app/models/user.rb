class User < ApplicationRecord
  has_secure_password validations: false

  attr_accessor :validate_code

  validates :password, presence: { on: :update }, confirmation: true, length: { minimum: 6, allow_nil: true }

  validates :mobile, presence: true
  validates :validate_code, presence: true, on: :create
end
