class ChangeColumToNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :announcement_id, true
  end
end
