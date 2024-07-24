class ProductsCleanupJob < ApplicationJob
  queue_as :default

  def perform
    expired_products = Product.where('expiry_date < ?', Time.current)
    
    if expired_products.any?
      # Send the email with the list of expired products
      ProductMailer.expired_products_notification(expired_products).deliver_now
      
      # Delete the expired products
      expired_products.each do |product|
        product.destroy
        puts "Deleted product: #{product.id}"
      end
    end
  end
end
