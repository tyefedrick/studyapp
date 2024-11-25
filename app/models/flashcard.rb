class Flashcard < ApplicationRecord
  belongs_to :flashcard_set

  validates :question, :answer, presence: true
end
