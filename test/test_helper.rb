# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/mock'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    include FactoryBot::Syntax::Methods

    def with_mocked_daily_prices_fetcher(count: 1, &block)
      daily_prices = JSON.parse(file_fixture('alphavantage_daily_prices.json').read)
      @mock = Minitest::Mock.new
      @mock_result = MockClass.new(daily_prices)
      count.times do
        @mock.expect(:call, @mock_result, [Object])
      end
      ::Companies::Prices::DailyPriceFetcher.stub :new, @mock, &block

      @mock.verify
    end
  end
end

class MockClass
  def initialize(mocked_result)
    @mocked_result = mocked_result
  end

  def call
    @mocked_result
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
    with.library :rails
  end
end
