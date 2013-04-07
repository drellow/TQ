class CreateFeedItems < ActiveRecord::Migration
  def change
    create_table :feed_items do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :scope
      t.string :path
      t.string :body
      t.boolean :read, :default => false
      
      t.timestamps
    end
  end
end
