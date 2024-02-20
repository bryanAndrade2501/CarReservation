class UserMailer < ApplicationMailer

  def reset 
    @token = params[:user].signed_id(expires_in: 15.minutes, purpose: "password_reset")
    pp @token
    mail to: params[:user].email
  end

end
