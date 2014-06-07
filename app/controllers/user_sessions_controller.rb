class UserSessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      sign_in user
      redirect_to controller: :users, action: :show, id: user.id
    else
      flash.now[:danger] = 'Invalid password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
