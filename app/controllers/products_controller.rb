class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :show, :destroy]
    
  
    def index
        @products = Products.all    #When using resources this method is used for showing the list of all data
    end

    def show
        @products = Products.all   #When using resources this method is used for showing the single data
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
      @product.destroy
      redirect_to products_path, notice: 'Product was successfully deleted.'
    end

    private

    def product_params
      params.require(:products).permit(:name, :supplier_name,:gst_percentage,:profit_percentage, :purchase_price, :sales_price)
    end

    def set_product
      @product = Products.find(params[:id])
    end

end