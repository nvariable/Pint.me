class ApplicationController < ActionController::Base
  protect_from_forgery
  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def require_login
    unless signed_in?
      flash[:error] = "You must login to access Pint.me"
      redirect_to root_url
    end
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end
end
