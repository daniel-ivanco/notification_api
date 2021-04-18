# frozen_string_literal: true

require 'test_helper'

# Test admin_user model validations
class AdminUserTest < ActiveSupport::TestCase
  context 'validations' do
    should validate_presence_of(:email)
    should validate_presence_of(:password)
    should validate_uniqueness_of(:email)
  end
end
