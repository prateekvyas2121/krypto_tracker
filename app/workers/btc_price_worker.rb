# frozen_string_literal: true

require 'net/http'

# btc_price_worker
class BtcPriceWorker
  include Sidekiq::Worker

  def perform
    api = Rails.application.credentials[:crypto_price_api]
    url = URI(api)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    @current_price = JSON.parse(response.read_body).first['current_price'].to_s
    alerts_to_be_triggered = Alert.order(created_at: :desc).where(price: @current_price, status: 0)
    user_ids = alerts_to_be_triggered.pluck(:user_id)
    alerts_to_be_triggered.update_all(status: 1, updated_at: Time.now)

    User.where(id: user_ids).each do |user|
      AlertMailer.btc_price_alert_mail(user, @current_price)
      puts '=' * 20 + "BITCOIN CURRENT PRICE IS #{@current_price} user #{user.email} notified with email!" + '=' * 20
    end
  end
end
