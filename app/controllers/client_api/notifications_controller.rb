# frozen_string_literal: true

module ClientApi
  # notifications controller
  class NotificationsController < BaseController
    before_action :authorize

    PER_PAGE = 100

    def index
      ::Notifications::SeenNotificationsMarker.new(notification_assignments: notification_assignments).call

      render json: ClientNotificationsSerializer.new(notification_assignments: notification_assignments).to_json
    end

    private

    def page
      page_param = params[:page].to_i
      page_param.positive? ? page_param : 1
    end

    def notification_assignments
      @notification_assignments ||= begin
        limit_offset = PER_PAGE * (page - 1)
        current_client.notification_assignments.includes(:notification).limit(PER_PAGE).offset(limit_offset).all
      end
    end
  end
end
