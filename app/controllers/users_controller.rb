class UsersController < ApplicationController
  layout 'sessions_layout', only:[:new, :edit]
  before_action :logged_in_user, only: [:show]
  before_action :current_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  
  def show
    # binding.pry
    # @user = current_user
  end

  
  def new
    @user = User.new
  end

  
  def edit
   
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to current_user, notice: 'User was successfully created.'
    else
      render :new 
    end
  end

  
  def update
    
    
  end

  
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end