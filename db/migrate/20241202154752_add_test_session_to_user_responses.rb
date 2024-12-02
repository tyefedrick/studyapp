class AddTestSessionToUserResponses < ActiveRecord::Migration[8.0]
  def change
    add_column :user_responses, :test_session, :string
  end
end
