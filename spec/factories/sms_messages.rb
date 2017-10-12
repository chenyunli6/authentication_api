FactoryGirl.define do
  factory :sms_message do
    sid '1111111'
    mobile Faker::PhoneNumber.cell_phone
    send_time DateTime.now
    text '短信验证码：123456'
    code '123456'
    send_status 'SUCCESS'
    report_status 'SUCCESS'
    fee 1
    user_receive_time Faker::Time.between(DateTime.now - 1, DateTime.now)
    error_msg nil
  end
end
