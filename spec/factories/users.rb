FactoryGirl.define do
  factory :user do
    mobile { Faker::PhoneNumber.cell_phone }
    validate_code '123456'
    password '123456'
    password_confirmation '123456'
  end
end
