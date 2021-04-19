# frozen_string_literal: true

require 'test_helper'

class SeenNotificationsMarkerTest < ActiveSupport::TestCase
  def setup
    @notification = create(:notification)
    @clients = create_list(:client, 5)
    @clients.each do |client|
      @notification.notification_assignments.create!(client_id: client.id)
    end
    @notification_assignments = @notification.notification_assignments
  end

  test 'updating seen_at to now' do
    @notification_assignments.each do |notification_assignment|
      assert notification_assignment.seen_at.nil?
    end

    ::Notifications::SeenNotificationsMarker
      .new(notification_assignments: @notification_assignments)
      .call

    @notification_assignments.each do |notification_assignment|
      assert notification_assignment.seen_at.today?
    end
  end
end
