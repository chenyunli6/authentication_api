class PasswordsController < ApplicationController
  def create
    @current_user.password = user_params[:password]
    @current_user.password_confirmation = user_params[:password_confirmation]
    @current_user.save!(user_params)
    success_response(Message.set_password_successfully)
  end

  private

  def user_params
    params.permit(
      :password,
      :password_confirmation
    )
  end
end
