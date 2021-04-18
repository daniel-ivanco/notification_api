module Companies
  module Prices
    class DailyPriceNormalizer
      def initialize(daily_prices:)
        @daily_prices = daily_prices
      end

      def call
        normalized_prices
      end

      private

      attr_reader :daily_prices

      def normalized_prices
        daily_prices.map do |price|
          {
            open: price.fetch(1).fetch('1. open').to_f,
            close: price.fetch(1).fetch('4. close').to_f
          }
        end
      end
    end
  end
end
