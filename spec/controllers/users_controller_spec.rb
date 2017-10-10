require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }

  let(:valid_attributes) do
    attributes_for(:user)
  end

  describe 'POST /signup' do
    context 'when valid request' do
      before {
        request.headers.merge! headers
        post :create, params: valid_attributes
      }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before {
        request.headers.merge! headers

      }

      it 'returns failure message' do
        expect{post :create, params: {}}.to raise_error(ActiveRecord::RecordInvalid, /Mobile can't be blank, Validate code can't be blank/)
      end
    end
  end
end
