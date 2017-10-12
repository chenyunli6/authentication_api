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
        expect { post :create, params: {} }.to raise_error(ActiveRecord::RecordInvalid, /Password can't be blank/)
      end

      it 'returns failure message when password_confirmation is not match' do
        expect { post :create, params: invalid_password }.to raise_error(ActiveRecord::RecordInvalid, /Password confirmation doesn't match Password/)
      end

      it 'returns failure message when password_confirmation is blank' do
        expect { post :create, params: { password: '123123', password_confirmation: '' } }.to raise_error(ActiveRecord::RecordInvalid, /Password confirmation doesn't match Password/)
      end
    end
  end
end
