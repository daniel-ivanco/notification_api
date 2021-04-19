module Clients
  class PortfolioPerformanceUpdater
    attr_reader :client, :portfolio_performance

    def initialize(client:, portfolio_performance:)
      @client = client
      @portfolio_performance = portfolio_performance
    end

    def call
      client.portfolio_performance = portfolio_performance
      client.portfolio_calculated_at = Time.now

      client.save!
    end
  end
end
