# frozen_string_literal: true

# notifications serializer
class NotificationsSerializer
  attr_reader :notifications

  def initialize(notifications:)
    @notifications = notifications
  end

  def to_json(*_args)
    @to_json ||= Oj.dump(to_h)
  end

  def to_h
    {
      notifications: notifications.map { |notification| NotificationSerializer.new(notification: notification).to_h }
    }
  end
end
