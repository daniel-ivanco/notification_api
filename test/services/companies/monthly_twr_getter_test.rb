# frozen_string_literal: true

require 'test_helper'

class MonthlyTwrGetterTest < ActiveSupport::TestCase
  test 'recalculating and updating nonexisting TWR for a company' do
    company = create(:company, monthly_twr: nil, twr_calculated_at: nil)

    with_mocked_daily_prices_fetcher do
      monthly_twr = ::Companies::MonthlyTwrGetter.new(company: company).call

      assert monthly_twr.present?
      assert company.twr_calculated_at.today?
      assert_equal monthly_twr, company.monthly_twr
    end
  end

  test 'recalculating and updating outdated TWR for a company' do
    default_monthly_twr = 1111.1
    outdated_date = Time.now - 1.day
    company = create(:company, monthly_twr: default_monthly_twr, twr_calculated_at: outdated_date)

    with_mocked_daily_prices_fetcher do
      monthly_twr = ::Companies::MonthlyTwrGetter.new(company: company).call

      assert monthly_twr.present?
      assert company.twr_calculated_at.today?
      assert_equal monthly_twr, company.monthly_twr
      assert_not_equal monthly_twr, default_monthly_twr
    end
  end

  test 'getting already existing and up to date company TWR' do
    default_monthly_twr = 1111.1
    company = create(:company, monthly_twr: default_monthly_twr, twr_calculated_at: Time.now)
    monthly_twr = ::Companies::MonthlyTwrGetter.new(company: company).call

    assert monthly_twr.present?
    assert_equal monthly_twr, company.monthly_twr
    assert_equal monthly_twr, default_monthly_twr
  end
end
