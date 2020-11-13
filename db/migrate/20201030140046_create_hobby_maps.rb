class CreateHobbyMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :hobby_maps do |t|
      t.references :post, foreign_key: true
      t.references :hobby, foreign_key: true

      t.timestamps
    end
  end
end
