# frozen_string_literal: true

module ClientApi
  # BaseController
  class BaseController < ActionController::API
    include ::WithCurrentClient
  end
end
