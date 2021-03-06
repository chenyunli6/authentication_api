require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST /auth/login' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        mobile: user.mobile,
        password: user.password,
        validate_code: nil
      }
    end

    let(:valid_credentials_with_code) do
      {
        mobile: user.mobile,
        password: nil,
        validate_code: user.validate_code
      }
    end

    let(:invalid_credentials) do
      {
        mobile: Faker::PhoneNumber.cell_phone,
        password: Faker::Internet.password,
        validate_code: Faker::Number.hexadecimal(3)
      }
    end

    before { request.headers.merge! headers }

    context 'when request is valid' do
      it 'returns an authentication token with mobile and password' do
        post :create, params: valid_credentials
        expect(json['data']['auth_token']).not_to be_nil
      end

      it 'returns an authentication token with mobile and validate_code' do
        create :sms_message, mobile: user.mobile, code: user.validate_code
        post :create, params: valid_credentials_with_code
        expect(json['data']['auth_token']).not_to be_nil
      end
    end

    context 'When request is invalid' do
      it 'returns a failure message' do
        post :create, params: invalid_credentials
        expect(response).to have_http_status(401)
        expect(json['msg']).to match(/Invalid credentials/)
      end
    end
  end
end
