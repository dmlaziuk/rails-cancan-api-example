# frozen_string_literal: true

module Api
  class SessionController < ApplicationController
    def create
      return render_unauthorized if user.blank? || user.password != User.hash_password(password)
      render json: { token: token, rules: Ability.new(user).to_list }
    end

    private

    def render_unauthorized
      render json: { message: 'Invalid email or password' }, status: 400
    end

    def session_params
      params.require(:session).permit(:email, :password)
    end

    def email
      session_params[:email]
    end

    def password
      session_params[:password]
    end

    def user
      @user ||= User.find_by(email: email)
    end

    def token
      @token ||= JWT.encode({ user_id: user.id }, Rails.application.secrets.jwt_secret, 'HS256')
    end
  end
end
