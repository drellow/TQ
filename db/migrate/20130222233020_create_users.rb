class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :color
      t.string :password_confirmation
      t.string :password_digest
      t.string :session_token
      t.boolean :admin
      t.string :title
      t.integer :score
      t.integer :legacy_score

      t.timestamps
    end
  end
end
