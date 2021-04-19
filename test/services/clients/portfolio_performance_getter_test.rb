# frozen_string_literal: true

require 'test_helper'

class PortfolioPerformanceGetterTest < ActiveSupport::TestCase
  def setup
    @client = create(:client, portfolio_performance: nil, portfolio_calculated_at: nil)

    5.times do |n|
      Company.create!(name: "name_#{n}")
    end

    Company.first(5).each{|company| @client.client_companies.create!(company: company, weight: 0.025)}
  end

  test 'recalculating and updating nonexisting portfolio performance for a client' do
    @client.update!(portfolio_performance: nil, portfolio_calculated_at: nil)

    with_mocked_daily_prices_fetcher(count: 5) do
      portfolio_performance = ::Clients::PortfolioPerformanceGetter.new(client: @client).call

      assert portfolio_performance.present?
      assert @client.portfolio_calculated_at.today?
      assert_equal portfolio_performance, @client.portfolio_performance
    end
  end

  test 'recalculating and updating outdated portfolio performance for a client' do
    default_portfolio_performance = 1111.1
    outdated_date = Time.now - 1.day
    @client.update!(portfolio_performance: default_portfolio_performance, portfolio_calculated_at: outdated_date)

    with_mocked_daily_prices_fetcher(count: 5) do
      portfolio_performance = ::Clients::PortfolioPerformanceGetter.new(client: @client).call

      assert portfolio_performance.present?
      assert @client.portfolio_calculated_at.today?
      assert_equal portfolio_performance, @client.portfolio_performance
      assert_not_equal portfolio_performance, default_portfolio_performance
    end
  end

  test 'getting already existing and up to date client portfolio performance' do
    default_portfolio_performance = 1111.1
    @client.update!(portfolio_performance: default_portfolio_performance, portfolio_calculated_at: Time.now)

    portfolio_performance = ::Clients::PortfolioPerformanceGetter.new(client: @client).call

    assert portfolio_performance.present?
    assert @client.portfolio_calculated_at.today?
    assert_equal portfolio_performance, @client.portfolio_performance
    assert_equal portfolio_performance, default_portfolio_performance
  end
end
