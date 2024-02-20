class PasswordResetsController < ApplicationController

    skip_before_action :protect_pages

   def new

   end

   def create
    @user = User.find_by(email: params[:email])
    pp @user
  
    if @user.present?
      UserMailer.with(user: @user).reset.deliver_later
    end
  
    redirect_to root_path, notice: "Si el correo es valido, te enviaremos un correo con las instrucciones para cambiar tu contraseña"
  end
  
  def edit
    pp params[:token]
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    pp @user
    pp params[:token]
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to root_path, alert: "El link de cambio de contraseña ha expirado, por favor intenta de nuevo"  
  end   

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")

    if @user.update(password_params)
      redirect_to root_path, notice: "Tu contraseña ha sido cambiada exitosamente"
    else
      render :edit
    end

  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  

end
