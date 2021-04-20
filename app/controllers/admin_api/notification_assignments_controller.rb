# frozen_string_literal: true

module AdminApi
  # notification assignments controller
  class NotificationAssignmentsController < BaseController
    before_action :authorize

    def create
      return render json: { error: create_validator.errors }, status: :bad_request unless create_validator.valid?

      client = Client.find_by_uuid!(safe_create_params[:client_id])
      notification = Notification.find_by_uuid!(safe_create_params[:notification_id])
      notification.notification_assignments.create!(client_id: client.id)

      head :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Client or Notification not found' }, status: :not_found
    end

    private

    def create_validator
      @create_validator ||= NotificationAssignmentsValidator.new(params: safe_create_params)
    end

    def safe_create_params
      params.permit(:client_id, :notification_id)
    end
  end
end
