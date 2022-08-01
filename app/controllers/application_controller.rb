# frozen_string_literal: true

# application_controller
class ApplicationController < ActionController::API
  include Pagy::Backend
  attr_accessor :current_user

  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_not_found

  def authenticate_user!
    return unauthorized_access if request.headers['Authorization'].blank?

    secret = Rails.application.credentials[:secret_key_base]
    encoding = 'HS256'
    token = request.headers['Authorization'].split(' ')[1]
    user_id = begin
      JWT.decode(token, secret, true, { algorithm: encoding }).first['user_id']
    rescue JWT::ExpiredSignature, JWT::VerificationError
      return unauthorized_access
    end
    @current_user = User.find(user_id)
  end

  def rescue_from_not_found
    nil
  end

  def unauthorized_access
    head(:unauthorized)
  end

  def per_page
    params[:per_page] ||= 1
  end
end
