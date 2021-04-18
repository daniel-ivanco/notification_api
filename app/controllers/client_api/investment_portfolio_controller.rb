# frozen_string_literal: true

module ClientApi
  # investment portfolio controller
  class InvestmentPortfolioController < BaseController
    before_action :authorize

    def show
      render json: ClientInvestmentPortfolioSerializer.new(client: current_client).to_json
    end
  end
end
