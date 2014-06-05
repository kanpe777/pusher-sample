class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:room, :destroy]
  def index
    @rooms = ChatRoom.all
  end

  def new
    @room = ChatRoom.new
  end

  def create
    @room = ChatRoom.new(chat_room_params)
    if @room.save
      redirect_to action: 'room', id: @room.id, notice: 'Chat room was successfully created.'
    else
      render :new
    end
  end

  # like show
  def room
  end

  def destroy
    @room.destroy
    redirect_to chat_rooms_url, notice: 'Chat room was successfully destroyed.'
  end

  private
    def set_chat_room
      @room = ChatRoom.find(params[:id])
    end

    def chat_room_params
      params.require(:chat_room).permit(:name)
    end
end
