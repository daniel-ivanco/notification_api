# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :client_companies

  validates :name, uniqueness: true
end
