class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings do |t|
      t.integer :topic_id, :null => false
      t.integer :shortener_id, :null => false
      t.timestamps
    end
  end
end
