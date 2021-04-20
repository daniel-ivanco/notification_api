# frozen_string_literal: true

# Admin Auth validations
class AdminAuthValidator
  include ActiveModel::Validations

  attr_reader :email, :password

  validates :email, :password, presence: true

  def initialize(params:)
    @email = params[:email]
    @password = params[:password]
  end
end
