# frozen_string_literal: true

require 'test_helper'

class PortfolioPerformanceUpdaterTest < ActiveSupport::TestCase
  def setup
    @client = create(:client, portfolio_performance: nil, portfolio_calculated_at: nil)
  end

  test 'updating portfolio_performance for a client' do
    portfolio_performance = 1.11
    ::Clients::PortfolioPerformanceUpdater.new(client: @client, portfolio_performance: portfolio_performance).call

    assert_equal portfolio_performance, @client.portfolio_performance
    assert @client.portfolio_calculated_at.today?
  end
end
