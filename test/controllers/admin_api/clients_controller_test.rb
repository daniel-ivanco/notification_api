# frozen_string_literal: true

require 'test_helper'

module AdminApi
  class ClientsControllerTest < ActionDispatch::IntegrationTest
    def setup
      @client = create(:client)

      ::AdminApi::BaseController.define_method(:authorize, -> { true })
    end

    test '#index OK' do
      get(admin_api_clients_url)
      assert_response :ok
    end
  end
end
