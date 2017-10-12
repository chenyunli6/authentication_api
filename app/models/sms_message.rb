class SmsMessage < ApplicationRecord
  include FakeSMS

  scope :latest_messages_by_mobile, lambda { |mobile, start_time, end_time|
    where('mobile = ? and send_time >= ? and send_time <= ?', mobile, start_time, end_time)
  }

  def self.deliver_fake_sms(mobile, code = generate_validate_code)
    return latest_message(mobile)&.code if latest_messages(mobile).length >= 3
    company = APP_CONFIG['sms']['company']
    sms = FakeSMS.build_fake_sms mobile, code, company
    sms_message = SmsMessage.new(sms)
    sms_message.code = code
    code if sms_message.save
  end

  def self.generate_validate_code
    SecureRandom.random_number.to_s.slice(-6..-1)
  end

  # all sms_messages that are not expired
  def self.latest_messages(mobile)
    end_time = Time.current
    start_time = end_time - APP_CONFIG['sms']['expires_in'].to_i
    @latest_message = latest_messages_by_mobile(mobile, start_time, end_time)
  end

  # last sms_message that are not expired
  def self.latest_message(mobile)
    latest_messages(mobile)&.last
  end

  def self.validated_code?(mobile, code)
    code == latest_message(mobile)&.code
  end
end
