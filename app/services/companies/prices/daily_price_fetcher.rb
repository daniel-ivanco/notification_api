module Companies
  module Prices
    class DailyPriceFetcher
      DOMAIN = "www.alphavantage.co".freeze
      BASE_URL = "https://#{DOMAIN}/query".freeze

      def initialize(company_name:)
        @company_name = company_name
        @api_key = Rails.application.credentials[Rails.env.to_sym][:alphavantage_apikey]
      end

      def call
        # As I am using standard alphavantage apikey, there is a limit to API call frequency
        # for 5 calls per minute and 500 calls per day. Therefore we need to postpone the execution for a while here.
        sleep(13)

        raise RuntimeError.new, "#{server_error} (company_name: #{company_name})" if server_error.present?

        prices
      end

      private

      attr_reader :company_name, :api_key

      def prices
        @prices ||= parsed_response.fetch('Time Series (Daily)')
      end

      def server_error
        parsed_response.dig("Error Message")
      end

      def parsed_response
        @parsed_response ||= JSON.parse(response)
      end

      def params
        {
          function: 'TIME_SERIES_DAILY_ADJUSTED', symbol: company_name, apikey: api_key
        }
      end

      def response
          RestClient.get("#{BASE_URL}", {params: params})
      end
    end
  end
end
