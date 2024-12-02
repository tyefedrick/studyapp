# app/models/question.rb
class Question < ApplicationRecord
  belongs_to :test_set
  has_many :answer_options, dependent: :destroy
  has_many :user_responses, dependent: :destroy

  accepts_nested_attributes_for :answer_options, allow_destroy: true

  validates :content, presence: true
  validates :question_type, presence: true

  enum :question_type, {
    multiple_choice: 0,
    multiple_selection: 1,
    fill_in_blank: 2,
    matching: 3
  }
end
