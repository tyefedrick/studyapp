class AddTestSetToUserResponses < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_responses, :test_set, null: false, foreign_key: true
  end
end
