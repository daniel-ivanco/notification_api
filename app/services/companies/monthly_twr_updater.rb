module Companies
  class MonthlyTwrUpdater
    attr_reader :company, :monthly_twr

    def initialize(company:, monthly_twr:)
      @company = company
      @monthly_twr = monthly_twr
    end

    def call
      company.monthly_twr = monthly_twr
      company.twr_calculated_at = Time.now

      company.save!
    end
  end
end
