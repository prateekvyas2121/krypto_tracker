require 'bcrypt'

class User < ApplicationRecord
	include BCrypt
	has_secure_password
	validates :email, presence: true, uniqueness: true
  	validates :password, presence: true

  	has_many :alerts, dependent: :destroy

	def auth_token
		secret = Rails.application.credentials[:secret_key_base]
		payload = { user_id: self.id, email: self.email }
		JWT.encode(payload, secret, 'HS256')
	end


	def decode(token)
		secret = Rails.application.credentials[:secret_key_base]
		JWT.decode(token, secret, true, { algorithm: 'HS256' })
	end
end
