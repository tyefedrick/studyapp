class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :test_set, null: false, foreign_key: true
      t.text :content, null: false
      t.text :explanation
      t.integer :question_type, null: false
      t.integer :position

      t.timestamps
    end
  end
end
