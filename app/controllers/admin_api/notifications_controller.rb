# frozen_string_literal: true

module AdminApi
  # notifications controller
  class NotificationsController < BaseController
    before_action :authorize

    PER_PAGE = 100

    def index
      notifications = Notification.limit(PER_PAGE).offset(PER_PAGE * (page - 1)).all

      render json: NotificationsSerializer.new(notifications: notifications).to_json
    end

    def show
      notification = Notification.find_by_uuid!(params[:id])

      render json: NotificationSerializer.new(notification: notification).to_json
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Not found' }, status: :not_found
    end

    def create
      return render json: { error: create_validator.errors }, status: :bad_request unless create_validator.valid?

      notification = Notification.create!(safe_create_params)

      render json: NotificationSerializer.new(notification: notification).to_json
    end

    private

    def page
      page_param = params[:page].to_i
      page_param.positive? ? page_param : 1
    end

    def create_validator
      @create_validator ||= CreateNotificationControllerValidator.new(params: safe_create_params)
    end

    def safe_create_params
      params.permit(:title, :active, :desc)
    end
  end
end
