# frozen_string_literal: true

require 'test_helper'

module AdminApi
  class NotificationAssignmentsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @client = create(:client)
      @notification = create(:notification)

      ::AdminApi::BaseController.define_method(:authorize, -> { true })
    end

    test '#create 200' do
      notification_assignments_params = {
        client_id: @client.reload.uuid,
        notification_id: @notification.reload.uuid
      }
      post(admin_api_notification_assignments_url, params: notification_assignments_params)

      assert_equal 200, response.status
    end

    test '#not_found 404' do
      notification_assignments_params = {
        client_id: 1,
        notification_id: 2
      }
      post(admin_api_notification_assignments_url, params: notification_assignments_params)

      assert_equal 404, response.status
    end

    test '#bad_request 400 - validation error' do
      notification_assignments_params = {
        notification_id: 2
      }
      post(admin_api_notification_assignments_url, params: notification_assignments_params)

      assert_equal 400, response.status
      refute JSON.parse(response.body).empty?
    end
  end
end
