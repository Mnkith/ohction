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

  def fb_login
    @user = User.find_or_create_by(id: auth['uid']) do |u|
      # binding.pry
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex 15
      u.image = auth['info']['image']
    end
    log_in @user
    redirect_to @user
  end

  def show
  end

  
  def destroy
    log_out
    redirect_to root_url
  end

  private

  def auth
    request.env['omniauth.auth']
  end
  
  def session_params
    params.require(:sessions).permit(:email, :password)
  end
  
end
