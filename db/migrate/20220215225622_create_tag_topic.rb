class CreateTagTopic < ActiveRecord::Migration[7.0]
  def change
    create_table :tagtopics do |t|
      t.string :tag_topic , :null => false
      t.timestamps
    end
  end
end
