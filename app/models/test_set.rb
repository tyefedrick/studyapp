# app/models/test_set.rb
class TestSet < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :user_responses, dependent: :destroy

  accepts_nested_attributes_for :questions,
    allow_destroy: true,
    reject_if: :all_blank

  validates :title, presence: true
end
