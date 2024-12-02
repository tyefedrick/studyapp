class AddDefaultValuesToUserResponses < ActiveRecord::Migration[8.0]
  def change
    change_column_default :user_responses, :correct_recent_attempts, 0
    change_column_default :user_responses, :incorrect_recent_attempts, 0
    change_column_default :user_responses, :correct_all_time_attempts, 0
    change_column_default :user_responses, :incorrect_all_time_attempts, 0
  end
end
