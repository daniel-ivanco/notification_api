# frozen_string_literal: true

# Client Auth validations
class ClientAuthValidator
  include ActiveModel::Validations

  attr_reader :auth_key

  validates :auth_key, presence: true

  def initialize(params:)
    @auth_key = params[:auth_key]
  end
end
