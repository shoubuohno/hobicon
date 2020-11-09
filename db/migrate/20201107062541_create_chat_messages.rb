class CreateChatMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_messages do |t|
      t.string :message
      t.integer :user_id, null: false
      t.integer :room_id

      t.timestamps
    end
  end
end
