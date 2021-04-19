# frozen_string_literal: true

require 'test_helper'

module ClientApi
  class NotificationsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @client = create(:client)
      @notification = create(:notification)
      @notification.notification_assignments.create!(client_id: @client.id)

      ::ClientApi::BaseController.define_method(:authorize, -> { true })
      ::ClientApi::BaseController.define_method(:current_client, -> { Client.first })
    end

    test '#index OK - with marked seen_at notification flag' do
      get(client_api_notifications_url)
      assert_response :ok
      refute JSON.parse(response.body)['notifications'].empty?
      assert @notification.notification_assignments.first.seen_at.today?
    end
  end
end
