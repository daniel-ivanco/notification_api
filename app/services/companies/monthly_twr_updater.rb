module Companies
  class MonthlyTwrUpdater
    def initialize(company:)
      @company = company
    end

    def call
      company.monthly_twr = monthly_twr
      company.twr_calculated_at = Time.now

      company.save!
    end

    private

    attr_reader :company

    def monthly_twr
      @monthly_twr ||= MonthlyTwrCalculator.new(company: company).call
    end
  end
end
