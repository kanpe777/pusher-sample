class ChatRoom < ActiveRecord::Base
  belongs_to :admin_user, class_name: :User
  has_many :participation_permissions, class_name: :ParticipationPermissionToChat, dependent: :destroy
  has_many :joined_users, through: :participation_permissions, source: :user

  def ChatRoom.initialized_chat
    chat = {
      messages: []
    }
  end

  class ChatRoom::Message
    require 'date'
    attr_reader :speaker, :date, :content
    def initialize(content, speaker = 'NANASHI')
      @speaker = speaker
      @date    = DateTime.now
      @content = content
    end
  end
end
