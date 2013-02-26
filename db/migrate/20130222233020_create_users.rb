class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :color
      t.boolean :admin
      t.string :title
      t.integer :score,        :default => 100
      t.integer :legacy_score, :default => 100

      t.timestamps
    end
  end
end
