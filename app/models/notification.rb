# frozen_string_literal: true

class Notification < ApplicationRecord
  has_many :notification_assignments
end
