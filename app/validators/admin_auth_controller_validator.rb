# frozen_string_literal: true

# Admin AuthController validations
class AdminAuthControllerValidator
  include ActiveModel::Validations

  attr_reader :email, :password

  validates :email, :password, presence: true

  def initialize(params:)
    @email = params[:email]
    @password = params[:password]
  end
end
