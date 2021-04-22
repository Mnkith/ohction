class ApplicationController < ActionController::Base
  # include SessionsHelper
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = 'Please log in.'
      redirect_to login_url
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !!current_user
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
  
end
