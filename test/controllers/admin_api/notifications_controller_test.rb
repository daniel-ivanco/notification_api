# frozen_string_literal: true

require 'test_helper'

module AdminApi
  class NotificationsControllerTest < ActionDispatch::IntegrationTest
    def setup
      ::AdminApi::BaseController.define_method(:authorize, -> { true })
    end

    test '#index OK' do
      get(admin_api_notifications_url)
      assert_response :ok
    end

    test '#show 404' do
      get(admin_api_notification_url('1'))
      assert_response :not_found
    end

    test '#show OK' do
      notification = create(:notification)
      get(admin_api_notification_url(notification.reload.uuid))
      assert_response :ok
    end

    test '#create 200' do
      notification_params = {
        title: 'test',
        desc: 'test dec',
        active: 'true'
      }
      post(admin_api_notifications_url, params: notification_params)

      assert_equal 200, response.status
      refute JSON.parse(response.body).empty?
    end

    test '#bad_request 400 - validation error' do
      notification_params = {
        desc: 'test dec',
        active: 'true'
      }
      post(admin_api_notifications_url, params: notification_params)

      assert_equal 400, response.status
      refute JSON.parse(response.body).empty?
    end
  end
end
