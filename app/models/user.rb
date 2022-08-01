# frozen_string_literal: true

require 'bcrypt'

# User model
class User < ApplicationRecord
  include BCrypt
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :alerts, dependent: :destroy

  def auth_token
    payload = { user_id: id, email: email }
    JWT.encode(payload, secret, encoding)
  end

  def decode(token)
    JWT.decode(token, secret, true, { algorithm: encoding })
  end
end
