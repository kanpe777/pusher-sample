class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to controller: :chat_rooms, action: :index
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed'
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
