class CreateHobbyMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :hobby_maps do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :hobby_id, null:false

      t.timestamps
    end
  end
end
