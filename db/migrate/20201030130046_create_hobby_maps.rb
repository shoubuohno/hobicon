class CreateHobbyMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :hobby_maps do |t|
      t.references :post, type: :integer, foreign_key: true
      t.references :hobby, type: :integer, foreign_key: true

      t.timestamps
    end
  end
end
