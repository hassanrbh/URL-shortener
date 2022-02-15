class AddIndexToVisits < ActiveRecord::Migration[7.0]
  def change
    add_index :visits, [:user_id, :shortener_id] , unique: true
  end
end
