# frozen_string_literal: true

class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    render json: { message: exception.message }, status: 403
  end

  def current_user
    return @current_user ||= User.find(token['user_id']) if token
    @current_user ||= User.new(permissions: %w[view])
  end

  private

  def token
    value = request.headers['Authorization']
    return if value.blank?
    @token ||= JWT.decode(value, Rails.application.secrets.jwt_secret, true, algorithm: 'HS256').first
  end
end
