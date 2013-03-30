class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :answer_id
      t.integer :user_id
      t.string :body
      t.boolean :read, :default => false
      
      t.timestamps
    end
  end
end
