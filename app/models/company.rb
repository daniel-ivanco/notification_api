# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :client_companies

  validates :name, presence: true
  validates :name, uniqueness: true
end
