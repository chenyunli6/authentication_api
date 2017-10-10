class AuthenticationController < ApplicationController
  def create
    auth_token =
      AuthenticateUser.new(auth_params[:mobile], auth_params[:password], auth_params[:validate_code]).call
    json_response(auth_token: auth_token)
  end

  private

  def auth_params
    params.permit(:mobile, :password, :validate_code)
  end
end
