# frozen_string_literal: true

class AdminUser < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
