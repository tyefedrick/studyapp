class AddCorrectToUserResponses < ActiveRecord::Migration[8.0]
  def change
    add_column :user_responses, :correct, :boolean
  end
end
