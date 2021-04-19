# frozen_string_literal: true

require 'test_helper'

class PortfolioPerformanceCalculatorTest < ActiveSupport::TestCase
  test 'portfolio calculation correctness' do
    client = create(:client)
    monthly_twrs = [1.12, 2.5, 3.5, -4.5]
    companies_count = monthly_twrs.count
    weight = 0.25
    portfolio_calculation_result = 0.655

    companies_count.times do |n|
      Company.create!(name: "name_#{n}")
    end

    Company.first(companies_count).each do |company|
      Client.first.client_companies.create!(company: company, weight: weight)
    end

    with_mocked_monthly_twr_getter(monthly_twrs: monthly_twrs) do
      monthly_twr = ::Clients::PortfolioPerformanceCalculator.new(client_id: client.id).call

      assert_in_delta(portfolio_calculation_result, monthly_twr, 0.00000000000001)
    end
  end

  private

  def with_mocked_monthly_twr_getter(monthly_twrs:, &block)
    @mock = Minitest::Mock.new

    mock_result = MockClass.new(monthly_twrs[0])
    @mock.expect(:call, mock_result, [Object])

    mock_result = MockClass.new(monthly_twrs[1])
    @mock.expect(:call, mock_result, [Object])

    mock_result = MockClass.new(monthly_twrs[2])
    @mock.expect(:call, mock_result, [Object])

    mock_result = MockClass.new(monthly_twrs[3])
    @mock.expect(:call, mock_result, [Object])

    ::Companies::MonthlyTwrGetter.stub :new, @mock, &block

    @mock.verify
  end
end
