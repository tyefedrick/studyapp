class CreateUserResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :user_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.integer :correct_recent_attempts, default: 0
      t.integer :incorrect_recent_attempts, default: 0
      t.integer :correct_all_time_attempts, default: 0
      t.integer :incorrect_all_time_attempts, default: 0

      t.timestamps
    end

    add_index :user_responses, [ :user_id, :question_id ], unique: true
  end
end
