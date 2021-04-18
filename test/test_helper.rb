ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/mock'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include FactoryBot::Syntax::Methods

  def with_mocked_daily_prices_fetcher(&block)
    daily_prices = JSON.parse(file_fixture('daily_prices.json').read)
    @mock = Minitest::Mock.new
    @mock_result = MockClass.new(daily_prices)
    @mock.expect(:call, @mock_result, [Object])

    ::Companies::Prices::DailyPriceFetcher.stub :new, @mock, &block

    @mock.verify
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
