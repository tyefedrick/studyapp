class CreateAnswerOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :answer_options do |t|
      t.references :question, null: false, foreign_key: true
      t.text :content, null: false
      t.boolean :correct, default: false
      t.integer :matching_id

      t.timestamps
    end
  end
end
