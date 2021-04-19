# frozen_string_literal: true

require 'test_helper'

class TwrCalculatorTest < ActiveSupport::TestCase
  test 'twr calculation for positive case' do
    daily_prices = [{ open: 10, close: 20 }, { open: 20.5, close: 50.5 }, { open: 100, close: 90 }]

    monthly_twr = ::Companies::TwrCalculator
                  .new(daily_prices: daily_prices)
                  .call

    assert_in_delta(3.43414634146341, monthly_twr, 0.00000000000001)
  end

  test 'twr calculation for negative case' do
    daily_prices = [{ open: 20, close: 10 }, { open: 40.6, close: 10.1 }, { open: 100, close: 90 }]

    monthly_twr = ::Companies::TwrCalculator
                  .new(daily_prices: daily_prices)
                  .call

    assert_in_delta(-0.88805418719211, monthly_twr, 0.00000000000001)
  end
end
