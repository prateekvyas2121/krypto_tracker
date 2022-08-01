class AlertMailer < ApplicationMailer
  default from: 'no-reply@letskrypto.com'

  def btc_price_alert_mail(user, price)
    @user = user
    @price = price
    mail(to: user.email, subject: "Alert! BTC is at #{price}")
  end
end
