class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }
  validates :password_confirmation, length: { minimum: 4 }

  def self.authenticate_with_credentials(_email, _password)
    return nil if _email.nil?

    user = User.find_by_email(_email.strip.downcase)
    return user if user && user.authenticate(_password)

    nil
  end
end
