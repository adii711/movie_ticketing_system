class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  skip_before_action :authorized_admin, only: [:new, :create]
  
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:alert] = "Email or password is invalid"
      redirect_to login_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url, notice: "Logged out successfully!"
  end

  private

  def session_params
    params.permit(:authenticity_token, :email, :password)
  end
end
