module Companies
  class MonthlyTwrCalculator
    def initialize(company:)
      @company = company
    end

    def call
      monthly_twr
    end

    private

    attr_reader :company

    def monthly_twr
      @monthly_twr ||= rate_of_returns.reduce(:*) - 1
    end

    def rate_of_returns
      daily_prices.map do |price|
        1 + rate_of_return(price)
      end
    end

    def rate_of_return(price)
      ( price[:close] - price[:open] ) / price[:open]
    end

    def daily_prices
      @daily_prices ||= Prices::DailyPriceGetter.new(company_name: company.name).call
    end
  end
end
