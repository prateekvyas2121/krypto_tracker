# frozen_string_literal: true

# sessions controller
class SessionController < ApplicationController
  # POST /session/sign_up
  # params[:email]
  # params[:password]
  def sign_up
    @user = User.new(user_params)
    if @user.save
      render json: { email: @user.email, auth_token: @user.auth_token }
    else
      render json: @user.errors
    end
  end

  # POST /session/sign_in
  # params[:email]
  # params[:password]
  def sign_in
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      render json: { email: @user.email, auth_token: @user.auth_token }, status: :ok
    else
      render json: { message: 'recheck the credentials you entered' }, status: :unauthorized
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password
    )
  end
end
