class SessionsController < ApplicationController
  include SessionsHelper
  before_action :set_session, only: %i[show edit update destroy]

  # GET /sessions or /sessions.json
  def index
    @sessions = Session.all
  end

  # def signup
  #   @user = User.new
  #   redirect_to new_user_path
  # end

  # def fonts
  #   redirect_to "/app/assets/fonts/poppins"
  # end
  # GET /sessions/1 or /sessions/1.json
  def show; end

  # GET /sessions/new
  def new
    @user = User.new
  end

  # GET /sessions/1/edit
  def edit; end

  # POST /sessions or /sessions.json
  def create
    # binding.pry
    params.require(:user).permit(:email, :password)
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      log_in user
      redirect_back_or user
    else
      flash[:danger] = "Invalid email/password combination" # Don't know how flash message persist to render, thought we have to use flash.now
      render 'new'
    end
  end

  # PATCH/PUT /sessions/1 or /sessions/1.json
  # def update
  #   respond_to do |format|
  #     if @session.update(session_params)
  #       format.html { redirect_to @session, notice: 'Session was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @session }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @session.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  

  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def session_params
    params.require(:sessions).permit(:email, :password)
  end
end
