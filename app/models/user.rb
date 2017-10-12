class User < ApplicationRecord
  has_secure_password :validations => false

  validates :password,
          # you only need presence on create
          :presence => { :on => :update },
          # allow_nil for length (presence will handle it on create)
          :length   => { :minimum => 6, :allow_nil => true },
          # and use confirmation to ensure they always match
          :confirmation => true

  attr_accessor :validate_code

  validates_presence_of :validate_code, on: :create

  validates_presence_of :mobile
end
