# frozen_string_literal: true

module AdminApi
  # BaseController
  class BaseController < ActionController::API
    include ::WithCurrentAdmin
  end
end
