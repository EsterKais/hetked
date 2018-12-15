# frozen_string_literal: true

class ApplicationController < ActionController::API
  require "jwt"

  def authenticate_user!
    return render_unauthorized unless current_user
  end

  private

  def decoded_token
    return unless request.headers["Authentication"]

    @decoded_token ||= JWT.decode(
      request.headers["Authentication"],
      nil,
      false
    )
  end

  def current_user
    return unless decoded_token

    @current_user ||= User.find(decoded_token.first["id"])
  end

  def render_unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
