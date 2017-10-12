require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST /signup' do
    context 'when valid request' do
      before do
        mobile = Faker::PhoneNumber.cell_phone
        create :sms_message, mobile: mobile, code: '123456'
        post :create, params: { mobile: mobile, validate_code: '123456' }
      end

      it 'creates a new user' do
        expect(response).to have_http_status(200)
      end

      it 'returns success message' do
        expect(json['msg']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['data']['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      it 'returns failure message' do
        post :create, params: {}
        expect(json['msg']).to match(/Sorry, mobile not found/)
      end

      it 'returns failure message' do
        mobile = Faker::PhoneNumber.cell_phone
        create :user, mobile: mobile
        post :create, params: { mobile: mobile }
        expect(json['msg']).to match(/User has already exist/)
      end

      it 'returns failure message' do
        mobile = Faker::PhoneNumber.cell_phone
        create :sms_message, mobile: mobile, code: '123456'
        post :create, params: { mobile: mobile, validated_code: '234567' }
        expect(json['msg']).to match(/Invalid code/)
      end
    end
  end
end
