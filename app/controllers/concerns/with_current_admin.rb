# frozen_string_literal: true

# Authenticate
module WithCurrentAdmin
  extend ActiveSupport::Concern

  def authorize
    return render_auth_error unless current_admin
  end

  def current_admin
    return unless admin_uuid

    @current_admin ||= AdminUser.where(uuid: admin_uuid).take
  end

  def admin_uuid
    decoded_jwt&.first&.dig('sub')
  end

  def decoded_jwt
    @decoded_jwt ||= JWT.decode jwt, Rails.application.credentials[Rails.env.to_sym][:auth_private_key], true,
                                { verify_iat: true, algorithm: 'HS256' }
  rescue JWT::DecodeError
    nil
  end

  def jwt
    header_jwt
  end

  def header_jwt
    request.headers['Authorization']&.split(' ')&.last
  end

  def render_auth_error
    render json: { type: 'authentication required' }, status: :unauthorized
  end
end
