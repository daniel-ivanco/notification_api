module Companies
  class TwrCalculator
    def initialize(daily_prices:)
      @daily_prices = daily_prices
    end

    def call
      monthly_twr
    end

    private

    attr_reader :daily_prices

    def monthly_twr
      @monthly_twr ||= rate_of_returns.reduce(:*) - 1
    end

    def rate_of_returns
      daily_prices.map do |price|
        1 + rate_of_return(price)
      end
    end

    def rate_of_return(price)
      ( price[:close] - price[:open].to_f ) / price[:open].to_f
    end
  end
end
