# frozen_string_literal: true

# Client AuthController validations
class ClientAuthControllerValidator
  include ActiveModel::Validations

  attr_reader :auth_key

  validates :auth_key, presence: true

  def initialize(params:)
    @auth_key = params[:auth_key]
  end
end
