class UsersController < ApplicationController
  before_action :signed_in_user, only: [:destroy, :show]
  def index
    clear_location
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
    user = User.find(params[:id])
    user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed'
  end

  def show
    @user = User.find(params[:id])
    unless current_user?(@user)
      correct_user = current_user
      redirect_to action: :show, id: correct_user.id
      return
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    def signed_in_user
      store_location
      unless signed_in?
        flash[:warning] = "Please sign in"
        redirect_to signin_url
      end
    end
end
