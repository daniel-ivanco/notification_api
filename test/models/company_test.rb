# frozen_string_literal: true

require 'test_helper'

# Test company model validations
class CompanyTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many(:client_companies)
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
  end
end
