class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.integer :vote, :null => false, default: 0
      t.timestamps
    end
  end
end
