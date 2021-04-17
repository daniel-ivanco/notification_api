module Companies
  class MonthlyTwrGetter
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
      return true if company.monthly_twr.blank?

      return true if company.twr_calculated_at.blank?

      !company.twr_calculated_at.today?
    end

    def update_monthly_twr
      ::Companies::MonthlyTwrUpdater.new(company: company).call
    end
  end
end
