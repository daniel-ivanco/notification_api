# frozen_string_literal: true

require 'test_helper'

class LastDaysPriceGetterTest < ActiveSupport::TestCase
  test 'getting last 30 days prices' do
    with_mocked_daily_prices_fetcher do
      prices = ::Companies::Prices::LastDaysPriceGetter
        .new(company_name: 'test', last_days_number: 30)
        .call

      assert_equal prices.count, 30
    end
  end
end
