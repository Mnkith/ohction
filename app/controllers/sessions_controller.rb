class SessionsController < ApplicationController
  include SessionsHelper
  layout 'sessions_layout'
  

  
  def new
    @user = User.new
  end

  
  def create
    # binding.pry
    # params.require(:user).permit(:email, :password)
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      log_in user
      redirect_back_or user
    else
      flash.now[:danger] = "Invalid email/password combination" # Don't know how flash message persist to render, thought we have to use flash.now
      render 'new'
    end
  end

  
  def destroy
    log_out
    redirect_to root_url
  end

  private

  
  def session_params
    params.require(:sessions).permit(:email, :password)
  end
  
end
