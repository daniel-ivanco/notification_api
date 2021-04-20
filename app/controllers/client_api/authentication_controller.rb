# frozen_string_literal: true

module ClientApi
  # authentication controller
  class AuthenticationController < BaseController
    def authenticate
      return render json: { error: validator.errors }, status: :bad_request unless validator.valid?

      if current_client_uuid.present?
        render json: JwtGenerator.new(sub: current_client_uuid).call
      else
        render json: { error: 'Invalid client auth_key' }, status: :unauthorized
      end
    end

    private

    def validator
      @validator ||= ClientAuthValidator.new(params: params)
    end

    def current_client_uuid
      # this is just super simple hardcoded auth process validating auth_key for 1st and 2nd client
      hardcoded_clients_auth_keys =
        {
          jEGHzpHurQsX4m9VD8meJg: Client.first.uuid,
          '0LMLjxFM9E9LW5n0uK5hqQ': Client.second.uuid
        }

      hardcoded_clients_auth_keys[params[:auth_key].to_sym]
    end
  end
end
