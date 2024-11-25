class User < ApplicationRecord
   # Define user roles
   # enum role: { regular: 0, admin: 1 }

   # Secure password handling
   has_secure_password

  # Associations
  has_many :sessions, dependent: :destroy

  # Set default role after initialization
  after_initialize :set_default_role, if: :new_record?

  # For flash cards
  has_many :flashcard_sets, dependent: :destroy

  def self.authenticate_by(email_address:, password:)
    user = find_by(email_address: email_address)
    user&.authenticate(password)
  end

  private

  def set_default_role
    self.admin ||= false
  end
end
