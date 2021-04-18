# frozen_string_literal: true

require 'test_helper'

# Test notification assignment model validations
class NotificationAssignmentTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:notification)
    should belong_to(:client)
  end
end
