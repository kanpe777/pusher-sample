class PusherController < ApplicationController
  def index
    Pusher.url = ENV["PUSHER_URL"]
    @messages = Message.all
  end

  def create
    render :nothing => true

    message = Message.create(content: params[:data])
    view_message = { date: message.created_at, content: message.content.gsub(/\r\n|\r|\n/, "<br />") }
    Pusher['test_channel'].trigger('chat_event', { message: view_message })
  end

  def clear
    Message.delete_all
    redirect_to action: "index"
  end
end
