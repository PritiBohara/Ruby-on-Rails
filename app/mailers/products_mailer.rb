class ProductsMailer < ApplicationMailer
  default from: 'priti.bohara@nonstopio.com'

  def expired_products_notification(expired_products)
    @expired_products = expired_products
    mail(to: 'priti.bohara@nonstopio.com', subject: 'Expired Products Notification')
  end
end
