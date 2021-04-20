# frozen_string_literal: true

# Notification validations
class NotificationValidator
  include ActiveModel::Validations

  attr_reader :title, :desc, :active

  validates :title, :desc, :active, presence: true
  validates :active, inclusion: { in: %w[true false], message: 'is not boolean' }

  def initialize(params:)
    @title = params[:title]
    @desc = params[:desc]
    @active = params[:active]
  end
end
