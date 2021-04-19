# frozen_string_literal: true

require 'test_helper'

class DailyPriceNormalizerTest < ActiveSupport::TestCase
  test 'day prices data normalization' do
    open1 = 1.1
    open2 = 2.2
    close1 = 3.3
    close2 = 4.4

    prices = [
      ['2021-03-05',
       { '1. open' => open1.to_s, '2. high' => '123.75', '3. low' => '120.25', '4. close' => close1.to_s,
         '5. adjusted close' => '122.83', '6. volume' => '6949265', '7. dividend amount' => '0.0000', '8. split coefficient' => '1.0' }],
      ['2021-03-08',
       { '1. open' => open2.to_s, '2. high' => '126.85', '3. low' => '122.88', '4. close' => close2.to_s,
         '5. adjusted close' => '124.81', '6. volume' => '7239191', '7. dividend amount' => '0.0000', '8. split coefficient' => '1.0' }]
    ]
    normalized_prices = ::Companies::Prices::DailyPriceNormalizer.new(daily_prices: prices).call

    assert_equal normalized_prices.first[:open], open1
    assert_equal normalized_prices.second[:open], open2
    assert_equal normalized_prices.first[:close], close1
    assert_equal normalized_prices.second[:close], close2
  end
end
