class SmsMessage < ApplicationRecord
  include FakeSMS

  # def deliver(mobile, content, options = {})
  #   if options[:method] == :general
  #     Request.post 'sms/send.json', mobile: mobile, text: content, extend: options[:extend]
  #   else
  #     options[:code] = content
  #     message = parse_content options
  #     tpl_id = options[:tpl_id] || SmartSMS.config.template_id
  #     Request.post 'sms/tpl_send.json', tpl_id: tpl_id, mobile: phone, tpl_value: message
  #   end
  # end
  def self.deliver_fake_sms(mobile, code = self.generate_validate_code)
    company = APP_CONFIG['sms']['company']
    sms = FakeSMS.build_fake_sms mobile, code, company
    sms_message = SmsMessage.new(sms)
    sms_message.code = code
    code if sms_message.save
  end

  def self.generate_validate_code
    SecureRandom.random_number.to_s.slice(-6..-1)
  end

  def self.latest_message(mobile)
    end_time = Time.now
    start_time = end_time - APP_CONFIG['sms']['expires_in'].to_i
    where('mobile = ? and send_time >= ? and send_time <= ?', mobile, start_time, end_time)&.last
  end

  def self.validated_code?(mobile, code)
    code == self.latest_message(mobile)&.code
  end
end
