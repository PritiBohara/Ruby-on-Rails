require 'caxlsx'
require 'mail'

task :export_products => :environment do
  # Fetch your products data (adjust as per your application's model and data structure)
  products = Products.all

  Axlsx::Package.new do |p|
    p.workbook.add_worksheet(name: "Products") do |sheet|
      # Add headers
      sheet.add_row ["ID", "Name", "base_price"]

      # Add product data
      products.each do |product|
        sheet.add_row [product.id, product.name, product.base_price]
      end
    end

    # Save the Excel file temporarily
    filename = Rails.root.join('tmp', "products_export_#{Time.now.strftime("%Y%m%d%H%M%S")}.xlsx")
    p.serialize(filename)

    # Send the file via email
    mail = Mail.new
    mail.to = 'priti.bohara@nonstopio.com'
    mail.from = 'priti.bohara@nonstopio.com'
    mail.subject = 'Products Export'
    mail.body = 'Attached is the export of products data.'
    mail.add_file(filename)

    mail.delivery_method :smtp, {
      address: 'smtp.example.com',
      port: 587,
      domain: 'example.com',
      user_name: 'your_username',
      password: 'your_password',
      authentication: 'plain',
      enable_starttls_auto: true
    }

    mail.deliver!

    # Delete the temporary file after sending
    File.delete(filename)
  end
end
