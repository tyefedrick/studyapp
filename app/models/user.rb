class User < ApplicationRecord
   # Define user roles
   # enum role: { regular: 0, admin: 1 }

   # Secure password handling
   has_secure_password

  # Associations
  has_many :sessions, dependent: :destroy

  # Set default role after initialization
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.admin ||= false
  end
end
