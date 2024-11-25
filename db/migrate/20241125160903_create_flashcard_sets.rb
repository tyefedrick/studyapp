class CreateFlashcardSets < ActiveRecord::Migration[8.0]
  def change
    create_table :flashcard_sets do |t|
      t.string :title
      t.text :description
      t.integer :visibility
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
