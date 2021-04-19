class UsersController < ApplicationController
  layout 'sessions_layout', only:[:new, :edit]
  before_action :logged_in_user, only: [:show, :edit]
  before_action :current_user, only: %i[show edit update destroy]

  

  
  def show
    # binding.pry
    # @user = current_user
  end

  
  def new
    @user = User.new
  end

  
  def edit
    # @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to current_user, notice: 'User was successfully created.'
    else
      render :new, layout: 'sessions_layout'
    end
  end

  
  def update
    if @current_user.update user_params
      redirect_to current_user, notice: 'Your acount was updated successfully'
    else
      render :edit, layout: 'sessions_layout'
    end
  end

  
  def destroy
    # binding.pry
    log_out
    User.find(params[:id]).destroy
    redirect_to :root
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end

# thin start --ssl --ssl-key-file=host.key --ssl-cert-file=host.cert
