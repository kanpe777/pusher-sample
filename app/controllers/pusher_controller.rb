class PusherController < ApplicationController
  def index
    Pusher.url = ENV["PUSHER_URL"]
  end

  def create
    render :nothing => true
    Pusher['test_channel'].trigger('chat_event', { message: params[:data] })
    flash.keep[:notice] = "Your password has been updated successfully."
  end
end
