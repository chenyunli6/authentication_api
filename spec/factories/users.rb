FactoryGirl.define do
  factory :user do
    mobile { Faker::PhoneNumber.cell_phone }
    validate_code { Faker::Number.hexadecimal(4) }
    password '123456'
  end
end
