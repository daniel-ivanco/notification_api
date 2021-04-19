# frozen_string_literal: true

module Companies
  module Prices
    # gets last N days daily prices for a company
    class LastDaysPriceGetter
      def initialize(company_name:, last_days_number:)
        @company_name = company_name
        @last_days_number = last_days_number
      end

      def call
        prices
      end

      private

      attr_reader :company_name, :last_days_number

      def fetched_prices
        DailyPriceFetcher.new(company_name: company_name).call
      end

      def ordered_daily_prices
        fetched_prices.sort_by { |k, _v| Date.strptime(k, '%Y-%m-%d') }
      end

      def last_days_prices
        ordered_daily_prices.last(last_days_number)
      end

      def prices
        @prices ||= DailyPriceNormalizer.new(daily_prices: last_days_prices).call
      end
    end
  end
end
