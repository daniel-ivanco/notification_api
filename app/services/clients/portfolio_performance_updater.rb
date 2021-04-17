module Clients
  class PortfolioPerformanceUpdater
    def initialize(client:)
      @client = client
    end

    def call
      client.portfolio_performance = portfolio_performance
      client.portfolio_calculated_at = Time.now

      client.save!
    end

    private

    attr_reader :client

    def portfolio_performance
      @portfolio_performance ||= PortfolioPerformanceCalculator.new(client_id: client.id).call
    end
  end
end
