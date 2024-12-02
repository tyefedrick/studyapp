# app/models/answer_option.rb
class AnswerOption < ApplicationRecord
  belongs_to :question

  validates :content, presence: true
  validates :correct, inclusion: { in: [ true, false ] }

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.correct ||= false
  end
end
