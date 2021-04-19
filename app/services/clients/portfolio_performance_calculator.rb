# frozen_string_literal: true

module Clients
  # calculates portfolio performance for a client's companies
  class PortfolioPerformanceCalculator
    def initialize(client_id:)
      @client_companies = Client.includes(:client_companies, :companies).find(client_id).client_companies
    end

    def call
      portfolio_performance
    end

    private

    attr_reader :client_companies

    def portfolio_performance
      @portfolio_performance ||= wieghted_monthly_twrs.reduce(:+)
    end

    def wieghted_monthly_twrs
      client_companies.map do |client_company|
        monthly_twr(client_company.company) * client_company.weight.to_f
      end
    end

    def monthly_twr(company)
      ::Companies::MonthlyTwrGetter.new(company: company).call
    end
  end
end
