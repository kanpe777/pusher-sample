class CreateFriendShips < ActiveRecord::Migration
  def change
    create_table :friend_ships do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.boolean :approval, default: false

      t.timestamps
    end
  end
end
