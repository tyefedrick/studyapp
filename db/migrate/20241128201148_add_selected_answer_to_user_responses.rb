class AddSelectedAnswerToUserResponses < ActiveRecord::Migration[8.0]
  def change
    add_column :user_responses, :selected_answer, :string
  end
end
