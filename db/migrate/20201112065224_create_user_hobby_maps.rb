class CreateUserHobbyMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :user_hobby_maps do |t|
      t.references :hobby, type: :integer, foreign_key: true
      t.references :user, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end
