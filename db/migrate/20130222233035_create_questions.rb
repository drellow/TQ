class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :body
      t.text :info
      t.integer :user_id
      t.boolean :posted_answers
      t.boolean :emailed_answers

      t.timestamps
    end
  end
end
