require 'rails_helper'

RSpec.describe SmsMessagesController, type: :controller do
  describe '#create' do
    context 'when request is valid' do
      it 'send sms message and return code' do
        post :create, params: { mobile: Faker::PhoneNumber.cell_phone }
        expect(response).to have_http_status(200)
        expect(json['data']['code']).not_to be_nil
      end
    end
  end
end
