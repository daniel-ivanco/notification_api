# frozen_string_literal: true

require 'test_helper'

module ClientApi
  class InvestmentPortfolioControllerTest < ActionDispatch::IntegrationTest
    def setup
      @investmen_portfolio = 111.1
      @client = create(:client, portfolio_performance: @investmen_portfolio, portfolio_calculated_at: Time.now)
      5.times do |n|
        Company.create!(name: "name_#{n}")
      end
      Company.first(5).each { |company| @client.client_companies.create!(company: company, weight: 0.025) }

      ::ClientApi::BaseController.define_method(:authorize, -> { true })
      ::ClientApi::BaseController.define_method(:current_client, -> { Client.first })
    end

    test '#index OK - contains correct investmen portfolio performance value' do
      get(client_api_investment_portfolio_url)
      parsed_body = JSON.parse(response.body)

      assert_response :ok
      assert_equal @investmen_portfolio, parsed_body.dig('client_investment_portfolio', 'portfolio_performance').to_f
      refute parsed_body.dig('client_investment_portfolio', 'portfolio_companies').empty?
    end
  end
end
