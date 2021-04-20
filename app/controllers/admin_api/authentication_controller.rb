# frozen_string_literal: true

module AdminApi
  # authentication controller
  class AuthenticationController < BaseController
    def authenticate
      return render json: { error: validator.errors }, status: :bad_request unless validator.valid?

      user_authenticator = ::AdminUsers::Authenticator.new(email: params[:email], password: params[:password])

      if user_authenticator.call
        render json: user_authenticator.result
      else
        render json: { error: user_authenticator.errors }, status: :unauthorized
      end
    end

    private

    def validator
      @validator ||= AdminAuthValidator.new(params: params)
    end
  end
end
