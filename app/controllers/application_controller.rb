class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin, :admin_logged_in?, :logged_in?
  before_action :authorized
  before_action :authorized_admin
  allow_browser versions: :modern

  def current_admin
    if session[:admin_id]
      @current_admin ||= Admin.find_by(id: session[:admin_id])
    end
  end

  def admin_logged_in?
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorized_admin
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end

  def authorized
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
