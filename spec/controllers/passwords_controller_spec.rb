require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do
  describe '#create' do
    let!(:user) { create(:user, mobile: '18011111111') }
    let(:headers) { valid_headers }
    let(:valid_password) do
      {
        password: user.password,
        password_confirmation: user.password_confirmation
      }
    end

    let(:invalid_password) do
      {
        password: user.password,
        password_confirmation: '123212'
      }
    end

    before { request.headers.merge! headers }

    context 'when password is valid' do
      it 'update user password_digest' do
        post :create, params: valid_password
        expect(response).to have_http_status(200)
        expect(json['msg']).to match(/Set password successfully/)
      end
    end

    context 'when password is not valid' do
      it 'returns failure message' do
        post :create, params: {}
        expect(response).to have_http_status(422)
        expect(json['msg']).to match(/Password can't be blank/)
      end

      it 'returns failure message when password_confirmation is not match' do
        post :create, params: invalid_password
        expect(response).to have_http_status(422)
        expect(response.message).to eq('Unprocessable Entity')
        expect(json['msg']).to match(/Password confirmation doesn't match Password/)
      end

      it 'returns failure message when password_confirmation is blank' do
        post :create, params: { password: '123123', password_confirmation: '' }
        expect(response).to have_http_status(422)
        expect(response.message).to eq('Unprocessable Entity')
        expect(json['msg']).to match(/Password confirmation doesn't match Password/)
      end
    end
  end
end
