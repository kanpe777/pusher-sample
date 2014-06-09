class CreateParticipationPermissionToChats < ActiveRecord::Migration
  def change
    create_table :participation_permission_to_chats do |t|
      t.integer :user_id
      t.integer :chat_room_id

      t.timestamps
    end
  end
end
