module Clients
  class PortfolioPerformanceGetter
    def initialize(client:)
      @client = client
    end

    def call
      update_portfolio_performance if portfolio_performance_outdated?

      client.portfolio_performance
    end

    private

    attr_reader :client

    def portfolio_performance_outdated?
      return true if client.portfolio_performance.blank?

      return true if client.portfolio_calculated_at.blank?

      !client.portfolio_calculated_at.today?
    end

    def update_portfolio_performance
      PortfolioPerformanceUpdater.new(client: client).call
    end
  end
end
