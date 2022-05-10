class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, length: { minimum: 4 }

  def self.authenticate_with_credentials(email, password)
    return nil if email.nil?

    user = User.find_by_email(email.strip.downcase)
    return user if user&.authenticate(password)

    nil
  end
end
