# frozen_string_literal: true

desc 'Whenever rake task test'
task btc_price: :environment do
  uri = URI('https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&order=market_cap_desc&per_page=100&page=1&sparkline=false')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri.path, { 'Content-Type' => 'application/json' })

  response = http.request(request)

  # body = JSON.parse(response.body) # e.g {answer: 'because it was there'}
  # Rails.logger.info "BTC price is #{}"
  Rails.logger.info('Logging to development env')
end
