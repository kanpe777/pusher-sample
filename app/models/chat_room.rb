class ChatRoom < ActiveRecord::Base
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
