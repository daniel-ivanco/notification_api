# frozen_string_literal: true

module Clients
  # gets client's current portfolio performance or calculates a new one if the original is outdated
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
      return true if client.portfolio_performance.blank? || client.portfolio_calculated_at.blank?

      !client.portfolio_calculated_at.today?
    end

    def portfolio_performance
      PortfolioPerformanceCalculator.new(client_id: client.id).call
    end

    def update_portfolio_performance
      PortfolioPerformanceUpdater.new(client: client, portfolio_performance: portfolio_performance).call
    end
  end
end
