# frozen_string_literal: true

# portfolio serializer
class ClientInvestmentPortfolioSerializer
  def initialize(client:)
    @client = Client.includes(:client_companies, :companies).find(client.id)
  end

  def to_json(*_args)
    @to_json ||= Oj.dump(to_h)
  end

  def to_h
    {
      client_investment_portfolio: {
        portfolio_performance: portfolio_performance,
        portfolio_companies: companies
      }
    }
  end

  private

  attr_reader :client

  def portfolio_performance
    ::Clients::PortfolioPerformanceGetter.new(client: client).call
  end

  def companies
    client.client_companies.map do |client_company|
      {
        name: client_company.company.name,
        weight: client_company.weight
      }
    end
  end
end
