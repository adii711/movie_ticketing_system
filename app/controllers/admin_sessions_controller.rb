class AdminSessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  skip_before_action :authorized_admin, only: [:new, :create]

  def new
  end

  def create
    admin = Admin.find_by(email: session_params[:email_address])
    if admin&.authenticate(session_params[:password])
      session[:admin_id] = admin.id
      redirect_to root_url
    else
      flash[:alert] = "Invalid email or password"
      redirect_to admin_login_path
    end
  end

  def destroy
    session.delete(:admin_id)
    redirect_to root_url, notice: "Logged out successfully!"
  end

  private

  def session_params
    params.permit(:email_address, :password)
  end
end
