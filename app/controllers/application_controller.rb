class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def user_signed_in?
    session[:valid]
  end

  def require_login
    unless user_signed_in?
      redirect_to login_path
    end
  end

  helper_method :require_login
  helper_method :user_signed_in?
end
