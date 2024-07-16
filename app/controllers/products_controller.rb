
class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
    
  
    def index
      if params[:search].present?   #search in List on name and on uuid fields
        @products = Products.where("name LIKE :search OR uuid LIKE :search", search: "%#{params[:search]}%")
      else
        @products = Products.all.sorted    #When using resources this method is used for showing the list of all data
      end
    end

    def show
        @products   #When using resources this method is used for showing the single data
    end

    def new
        @product = Products.new   
    end

    def create
        @product = Products.new(product_params)
        if @product.save
          redirect_to products_path, notice: 'Product was successfully created.'
        else
          render :new , status: :unprocessable_entity
        end
    end

    def edit
    end
    
    def update 
      if @product.update(product_params)
        redirect_to products_path, notice: 'Product was successfully Updated.'
      else
        render :edit , status: :unprocessable_entity
      end
    end

    def destroy
      if @product.destroy
      redirect_to products_path, notice: 'Product was successfully deleted.'
      else
        render :new , status: :unprocessable_entity
      end
    end

    #To generate the excel data
    def export_excel
      @products = Products.all
      
      respond_to do |format|
        format.xlsx do
          package = Axlsx::Package.new
          wb = package.workbook
          wb.add_worksheet(name: "Products") do |sheet|
            sheet.add_row ["ID", "Name", "BasePrice","GST"]
            @products.each do |product|
              sheet.add_row [product.id, product.name, product.base_price, product.gst_percentage]
            end
          end
          
          send_data package.to_stream.read, filename: "products_export_#{Time.now.strftime('%Y%m%d%H%M%S')}.xlsx"
        end
      end
    end

    private

    def product_params
      params.require(:products).permit(:name, :supplier_name,:base_price,:purchase_price,:gst_percentage,:is_inclusive,:sales_price)
    end

    def set_product
      if params[:id].nil?
        redirect_to products_path, alert: "Product ID cannot be nil."
      else
        begin
          @product = Products.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          redirect_to products_path, alert: "Product not found."
        end
      end
    end




end