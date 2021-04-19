# frozen_string_literal: true

# jwt token generator
class JwtGenerator
  attr_reader :sub, :exp

  def initialize(sub:, exp: 900)
    @sub = sub
    @exp = exp
  end

  def call
    jwt_payload = {
      exp: Time.now.to_i + exp,
      sub: sub,
      iat: Time.now.to_i,
      iss: 'yova'
    }
    JWT.encode jwt_payload, Rails.application.credentials[Rails.env.to_sym][:auth_private_key], 'HS256'
  end
end
