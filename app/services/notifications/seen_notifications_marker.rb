# frozen_string_literal: true

module Notifications
  class SeenNotificationsMarker
    def initialize(notification_assignments:)
      @notification_assignments = notification_assignments
    end

    def call
      notification_assignments.each { |notification_assignment| mark_as_seen(notification_assignment) }
    end

    private

    attr_reader :notification_assignments

    def mark_as_seen(notification_assignment)
      return if notification_assignment.seen_at.present?

      notification_assignment.seen_at = Time.now
      notification_assignment.save!
    end
  end
end
