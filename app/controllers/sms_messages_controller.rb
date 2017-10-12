class SmsMessagesController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    code = SmsMessage.deliver_fake_sms sms_message_params[:mobile]
    success('OK', code: code)
  end

  private

  def sms_message_params
    params.permit(:mobile)
  end
end
