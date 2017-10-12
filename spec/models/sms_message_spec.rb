require 'rails_helper'

RSpec.describe SmsMessage, type: :model do
  describe '#deliver_fake_sms' do
    it 'send deliver_fake_sms' do
      code = SecureRandom.random_number.to_s.slice(-6..-1)
      send_code = SmsMessage.deliver_fake_sms(Faker::PhoneNumber.cell_phone, code)
      expect(send_code).to eq(code)
    end

    it 'send the latest_message when send sms message greater than 3 times' do
      mobile = Faker::PhoneNumber.cell_phone
      FactoryGirl.create_list(:sms_message, 3, mobile: mobile)
      code = SmsMessage.latest_message(mobile)&.code
      expect(SmsMessage.deliver_fake_sms(mobile, '1111')).to eq(code)
    end
  end

  describe '#generate_validate_code' do
    it 'generate code of 6 length' do
      expect(SmsMessage.generate_validate_code.length).to eq 6
    end
  end

  describe '#latest_message' do
    context 'when has the latest message' do
      it 'return the latest message' do
        mobile = '18012121212'
        latest_message = create :sms_message, mobile: mobile
        expect(SmsMessage.latest_message(mobile)).to eq latest_message
      end
    end

    context 'when not has the latest message' do
      it 'return nil' do
        mobile = '18012121212'
        expect(SmsMessage.latest_message(mobile)).to be_nil
      end

      it 'returns nil' do
        sms_message = create :sms_message, send_time:
          Faker::Time.between(2.days.ago, 1.day.ago, :all)
        expect(SmsMessage.latest_message(sms_message.mobile)).to be_nil
      end
    end
  end

  describe '#validated_code?' do
    it 'returns true' do
      mobile = '18012121212'
      latest_message = create :sms_message, mobile: mobile
      allow(SmsMessage).to receive(:latest_message).and_return(latest_message)
      expect(SmsMessage.validated_code?(mobile, '123456')).to be_truthy
    end

    it 'returns true' do
      create :sms_message, mobile: '18012121212'
      expect(SmsMessage.validated_code?('18011111111', '123456')).to be_falsey
    end
  end
end
