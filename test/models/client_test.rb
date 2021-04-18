# frozen_string_literal: true

require 'test_helper'

# Test client model validations
class ClientTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many(:client_companies)
    should have_many(:companies)
    should have_many(:notifications)
    should have_many(:notification_assignments)
  end

  test 'max company limit per client' do
    client = create(:client)
    (ClientCompany::MAX_COMPANY_LIMIT + 10).times do |n|
      Company.create!(name: "sequence_#{n}")
    end

    assert_raises ActiveRecord::RecordInvalid do
      Company
        .first(ClientCompany::MAX_COMPANY_LIMIT + 1)
        .each{|company| client.client_companies.create!(company: company, weight: 0.025)}
    end
  end
end
