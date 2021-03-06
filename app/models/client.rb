# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :client_companies
  has_many :companies, through: :client_companies

  has_many :notification_assignments
  has_many :notifications, through: :notification_assignments
end
