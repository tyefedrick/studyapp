class CreateTestSets < ActiveRecord::Migration[8.0]
  def change
    create_table :test_sets do |t|
      t.string :title, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.boolean :show_score_as_you_go, default: false
      t.boolean :show_explanation, default: false
      t.boolean :show_answer, default: false

      t.timestamps
    end
  end
end
