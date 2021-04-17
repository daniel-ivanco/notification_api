# frozen_string_literal: true

# jwt token generator
class JwtGenerator
  attr_reader :sub

  def initialize(sub:)
    @sub = sub
  end

  def call
    jwt_payload = {
      sub: sub,
      iat: Time.now.to_i,
      iss: 'yova'
    }
    JWT.encode jwt_payload, Rails.application.credentials[Rails.env.to_sym][:auth_private_key], 'HS256'
  end
end
