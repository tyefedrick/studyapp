class User < ApplicationRecord
  has_secure_password

  # Associations
  has_many :sessions, dependent: :destroy
  has_many :flashcard_sets, dependent: :destroy
  has_many :test_sets, dependent: :destroy
  has_many :user_responses, dependent: :destroy

  # Callbacks
  after_initialize :set_default_role, if: :new_record?

  # Class methods
  def self.authenticate_by(email_address:, password:)
    user = find_by(email_address: email_address)
    user&.authenticate(password)
  end

  private

  def set_default_role
    self.admin ||= false
  end
end
