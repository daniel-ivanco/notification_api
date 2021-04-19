# frozen_string_literal: true

class ClientCompany < ApplicationRecord
  MAX_COMPANY_LIMIT = 40

  belongs_to :client
  belongs_to :company

  validates :company, uniqueness: { scope: :client }
  validate :validate_max_company_limit

  private

  def validate_max_company_limit
    errors.add(:companies, 'max limit exceeded') if client.companies.reload.size >= MAX_COMPANY_LIMIT
  end
end
