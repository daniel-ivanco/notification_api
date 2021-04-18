# frozen_string_literal: true

require 'test_helper'

# Test notification model validations
class NotificationTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many(:notification_assignments)
  end
end
