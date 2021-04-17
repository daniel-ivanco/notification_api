# frozen_string_literal: true

# Authenticate
module WithCurrentClient
  extend ActiveSupport::Concern

  def authorize(is_sep6: false)
    return render_auth_error unless current_client
  end

  def current_client
    return unless client_uuid

    @current_account ||= Client.where(uuid: client_uuid).take
  end

  def client_uuid
    decoded_jwt&.first&.dig('sub')
  end

  def decoded_jwt
    @decoded_jwt ||= JWT.decode jwt, Rails.application.credentials[Rails.env.to_sym][:auth_private_key], true,
                                { algorithm: 'HS256' }
  end

  def jwt
    header_jwt
  end

  def header_jwt
    request.headers['Authorization']&.split(' ')&.last
  end

  def render_auth_error
      render json: { type: 'authentication_required' }, status: :unauthorized
  end
end
