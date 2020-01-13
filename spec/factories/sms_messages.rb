FactoryGirl.define do
  factory :sms_message do
    sid '1111111'
    mobile Faker::PhoneNumber.cell_phone
    send_time DateTime.current
    text '短信验证码：123456'
    code '123456'
    send_status 'SUCCESS'
    report_status 'SUCCESS'
    fee 1
    user_receive_time Faker::Time.between(from: DateTime.current - 1, to: DateTime.current)
    error_msg nil
  end
end
