# frozen_string_literal: true

module ClientApi
  # investment portfolio controller
  class InvestmentPortfolioController < BaseController
    def show
      render json: ClientInvestmentPortfolioSerializer.new(client_id: current_client.id).to_json
    end
end
