class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:room, :destroy, :clear, :message]
  def index
    @rooms = ChatRoom.all
  end

  def new
    @room = ChatRoom.new
  end

  def create
    @room = ChatRoom.new(chat_room_params)
    if signed_in?
      @room.admin_user = current_user
    end
    hash_chat  = ChatRoom.initialized_chat
    @room.chat = hash_chat.to_json
    if @room.save
      redirect_to action: 'room', id: @room.id, notice: 'Chat room was successfully created.'
    else
      render :new
    end
  end

  # like show
  def room
    unless allow_enter_room?
      puts '----------------------------------'
      p params
      puts '----------------------------------'
      redirect_to controller: :application, action: :render_404
      return
    end
    Pusher.url = ENV["PUSHER_URL"]
    @messages = @room.chat['messages']
  end

  def destroy
    @room.destroy
    redirect_to chat_rooms_url, notice: 'Chat room was successfully destroyed.'
  end

  def clear
    @room.update_attributes(chat: ChatRoom.initialized_chat)
    redirect_to action: 'room', id: @room.id, notice: 'Chat history cleared'
  end

  def message
    render :nothing => true
    message  = ChatRoom::Message.new(params[:data])
    chat = @room.chat
    chat["messages"].push(message)
    @room.chat = chat.to_json
    @room.save
    view_message = {date: message.date, speaker: message.speaker, content: message.content.gsub(/\r\n|\r|\n/, "<br />")}
    Pusher["channel_#{@room.id}"].trigger('chat_event', { message: view_message, id: @room.id })
  end

  def invite
    invited_user = User.find_by(name: params[:search_name])
    room = ChatRoom.find(params[:id])
    if invited_user && !room.joined_users.include?(invited_user)
      permission = ParticipationPermissionToChat.create(user: invited_user, chat_room: room)
      room.participation_permissions.push(permission)
    end
    redirect_to action: :room
  end

  def throwout
    target_user = User.find(params[:target_id])
    room = ChatRoom.find(params[:id])
    if target_user && room.joined_users.include?(target_user)
      room.throwout(target_user)
    end
    redirect_to action: :room
  end

  private
    def set_chat_room
      @room = ChatRoom.find(params[:id])
    end

    def chat_room_params
      params.require(:chat_room).permit(:name, :private)
    end

    def allow_enter_room?
      !@room.private || @room.joined_users.include?(current_user) || (signed_in? && @room.admin_user == current_user) || (signed_in? && current_user.admin)
    end
end
