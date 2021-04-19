# frozen_string_literal: true

module Companies
  # gets company's monthly TWR or calculates a new one if actual is outdated
  class MonthlyTwrGetter
    DAYS_IN_THE_PAST = 30

    def initialize(company:)
      @company = company
    end

    def call
      update_monthly_twr if twr_outdated?

      company.monthly_twr
    end

    private

    attr_reader :company

    def twr_outdated?
      return true if company.monthly_twr.blank? || company.twr_calculated_at.blank?

      !company.twr_calculated_at.today?
    end

    def update_monthly_twr
      ::Companies::MonthlyTwrUpdater.new(company: company, monthly_twr: monthly_twr).call
    end

    def monthly_twr
      @monthly_twr ||= TwrCalculator.new(daily_prices: daily_prices).call
    end

    def daily_prices
      @daily_prices ||= Prices::LastDaysPriceGetter.new(
        company_name: company.name, last_days_number: DAYS_IN_THE_PAST
      ).call
    end
  end
end
