# frozen_string_literal: true

require 'net/http'

# btc_price_worker
class BtcPriceWorker
  include Sidekiq::Worker

  def perform
    # api = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&order=market_cap_desc&per_page=100&page=1&sparkline=false'
    api = Rails.application.credentials[:crypto_price_api]
    url = URI(api)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    current_price = JSON.parse(response.read_body).first['current_price']
    # Alert.where(price: current_price, status: 0).update_all(status: 1)
    puts '=' * 20 + "BITCOIN CURRENT PRICE IS #{current_price}" + '=' * 20
  end
end
