# frozen_string_literal: true

# client notifications serializer
class ClientNotificationsSerializer
  def initialize(notification_assignments:)
    @notifications = notification_assignments.map(&:notification)
  end

  def to_json(*_args)
    @to_json ||= Oj.dump(to_h)
  end

  def to_h
    {
      notifications: serialized_notifications
    }
  end

  private

  attr_reader :notifications

  def serialized_notifications
    notifications.map do |notification|
      notification
        .attributes.except('id')
    end
  end
end
