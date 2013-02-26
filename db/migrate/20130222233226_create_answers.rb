class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.text :body
      t.integer :score, :default => 25

      t.timestamps
    end
  end
end
