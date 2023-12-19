require 'bcrypt'

class User < ApplicationRecord

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def authenticate(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

end