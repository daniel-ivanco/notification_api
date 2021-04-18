# frozen_string_literal: true

# notification serializer
class NotificationSerializer
  def initialize(notification:)
    @notification = Notification.includes(notification_assignments: :client).find(notification.id)
  end

  def to_json(*_args)
    @to_json ||= Oj.dump(to_h)
  end

  def to_h
    serialized_notification
  end

  private

  attr_reader :notification

  def serialized_notification
    notification
      .attributes.except('id')
      .merge(notification_assignments: serialized_notification_assignments)
  end

  def serialized_notification_assignments
    notification.notification_assignments.map do |notification_assignment|
      {
        client_name: notification_assignment.client.name,
        seen: notification_assignment.seen_at.present?
      }
    end
  end
end
