# frozen_string_literal: true

# portfolio serializer
class ClientInvestmentPortfolioSerializer
  def initialize(client_id:)
    @client = Client.includes(:client_companies, :companies).find(client_id)
  end

  def to_json(*_args)
    @to_json ||= Oj.dump(to_h)
  end

  def to_h
    {
      investment_portfolio_performance: client.portfolio_performance,
      companies: companies,
    }
  end

  private

  attr_reader :client

  def companies
    client.client_companies.map do |client_company|
      {
        name: client_company.company.name,
        weight: client_company.weight
      }
    end
  end
end
