# frozen_string_literal: true

module AdminApi
  # clients controller
  class ClientsController < BaseController
    before_action :authorize

    PER_PAGE = 100

    def index
      clients = Client.limit(PER_PAGE).offset(PER_PAGE * (page - 1)).all

      render json: ClientsSerializer.new(clients: clients).to_json
    end

    private

    def page
      page_param = params[:page].to_i
      page_param.positive? ? page_param : 1
    end
  end
end
