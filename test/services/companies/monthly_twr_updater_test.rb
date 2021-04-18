# frozen_string_literal: true

require 'test_helper'

class MonthlyTwrUpdaterTest < ActiveSupport::TestCase
  def setup
    @company = create(:company, monthly_twr: nil, twr_calculated_at: nil)
  end

  test 'updating TWR for a company' do
    monthly_twr = 1.11
    ::Companies::MonthlyTwrUpdater.new(company: @company, monthly_twr: monthly_twr).call

    assert_equal monthly_twr, @company.monthly_twr
    assert @company.twr_calculated_at.today?
  end
end
