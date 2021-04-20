# frozen_string_literal: true

# Notification Assignments validations
class NotificationAssignmentsValidator
  include ActiveModel::Validations

  attr_reader :client_id, :notification_id

  validates :client_id, :notification_id, presence: true

  def initialize(params:)
    @client_id = params[:client_id]
    @notification_id = params[:notification_id]
  end
end
