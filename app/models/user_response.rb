# app/models/user_response.rb
class UserResponse < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :test_set

  attribute :correct_recent_attempts, :integer, default: 0
  attribute :incorrect_recent_attempts, :integer, default: 0
  attribute :correct_all_time_attempts, :integer, default: 0
  attribute :incorrect_all_time_attempts, :integer, default: 0
end
