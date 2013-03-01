class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :color,         :default => "#B1ABAB"
      t.string :provider
      t.string :access_token
      t.string :uid
      t.boolean :admin
      t.string :title          :default => "The New One"
      t.integer :score,        :default => 100
      t.integer :legacy_score, :default => 100

      t.timestamps
    end
  end
end
