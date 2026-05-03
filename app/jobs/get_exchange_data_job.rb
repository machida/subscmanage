require "uri"
require "json"

class GetExchangeDataJob < ApplicationJob
  queue_as :default

  retry_on Net::OpenTimeout, wait: 5.seconds, attempts: 10

  def perform(*args)
    Exchange::SUPPORTED_CURRENCIES.each do | currency |
      response = Net::HTTP.get_response(URI.parse("https://api.frankfurter.dev/v1/latest?base=#{currency}"))
      begin
        # For trigger Exception
        response.value

        raw_data = JSON.parse(response.body)
        Exchange.new(
          base_currency: raw_data["base"].to_s,
          base_date: raw_data["date"].to_date,
          data: raw_data.except("base", "date", "amount").to_json
        ).save
      rescue Net::HTTPExceptions => e
        Rails.logger.error "get_exchange_data_job failed with #{e.message}."
        next
      end
    end
  end
end
