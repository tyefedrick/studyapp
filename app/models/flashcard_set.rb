class FlashcardSet < ApplicationRecord
  belongs_to :user
  has_many :flashcards, dependent: :destroy

  accepts_nested_attributes_for :flashcards, allow_destroy: true

  VISIBILITY_OPTIONS = { private: 0, public: 1 }.freeze

  validates :title, presence: true
  validates :visibility, inclusion: { in: VISIBILITY_OPTIONS.values }

  # Helper methods for readability
  def public?
    visibility == VISIBILITY_OPTIONS[:public]
  end

  def private?
    visibility == VISIBILITY_OPTIONS[:private]
  end
end
