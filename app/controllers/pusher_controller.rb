class PusherController < ApplicationController
  def index
    Pusher.url = ENV["PUSHER_URL"]
  end

  def create
    render :nothing => true

    message = Message.create(content: params[:data])
    view_message = { date: message.created_at, content: message.content }
    Pusher['test_channel'].trigger('chat_event', { message: view_message })
  end
end
