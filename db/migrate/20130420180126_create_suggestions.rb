class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.integer :user_id
      t.text :body
      t.integer :score, :default => 0

      t.timestamps
    end
  end
end
