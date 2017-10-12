class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create

  before_action :check_user_exist, :check_mobile, :check_validate_code

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.mobile, nil, user_params[:validate_code]).call
    success(Message.account_created, auth_token: auth_token)
  end

  private

  def user_params
    params.permit(
      :mobile,
      :validate_code
    )
  end

  def check_user_exist
    return fail(Message.user_exist) if User.find_by_mobile(user_params[:mobile])
  end

  def check_mobile
    return fail(Message.not_found('mobile')) unless SmsMessage.find_by_mobile(user_params[:mobile])
  end

  def check_validate_code
    return fail(Message.invalid_code) unless SmsMessage.validated_code?(user_params[:mobile], user_params[:validate_code])
  end
end
