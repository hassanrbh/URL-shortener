class AddUserIdTovote < ActiveRecord::Migration[7.0]
  def change
    add_column :votes, :user_id, :integer, :null => false
  end
end
