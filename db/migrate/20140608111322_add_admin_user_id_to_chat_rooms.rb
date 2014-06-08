class AddAdminUserIdToChatRooms < ActiveRecord::Migration
  def change
    add_column :chat_rooms, :admin_user_id, :integer
  end
end
