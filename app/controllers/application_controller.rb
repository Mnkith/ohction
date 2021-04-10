class ApplicationController < ActionController::Base
  include SessionsHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
  
  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = 'Please log in.'
      redirect_to login_url
    end
  end
  
end
