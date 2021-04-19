# frozen_string_literal: true

module AdminUsers
  # authenticates user using passed credentials
  class Authenticator
    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def call
      user_authenticated?
    end

    def result
      @result ||= JwtGenerator.new(sub: admin_user.uuid).call if user_authenticated?
    end

    def errors
      @errors ||= admin_user.errors
    end

    private

    attr_reader :email, :password

    def admin_user
      @admin_user ||= AdminUser.find_by_email(email)
    end

    def user_authenticated?
      @user_authenticated ||= authenticate_user
    end

    def authenticate_user
      return true if admin_user&.authenticate(password)

      admin_user.errors.add :user_authentication, 'invalid credentials'
      false
    end
  end
end
