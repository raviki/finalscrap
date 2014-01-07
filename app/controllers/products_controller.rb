class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  include ApplicationHelper

  # GET /products
  # GET /products.json
  def index 
    add_breadcrumb "index", index_path
    if params[:id].present?
      @category = Category.find(params[:id]) 
      if @category
        @products = @category.activeProducts  
      else 
        @product = Product.find(params[:id]) 
        if @product 
          redirect_to @product  
        end
      end 
    end
       
    if params[:select].present?
      @category = Category.find(params[:select])
      if @category
        @products = @category.activeProducts.standard_search(params[:key])
      end
    end
    if !@products        
        @products = Product.admin_grid(params,true,params[:key]).order(sort_column + " " + sort_direction).
                                             paginate(:page => pagination_page, :per_page => pagination_rows)
      @cart_items = current_cart.cart_items
    end
    @categories = Category.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if !(@category && @product)
      store_location()
      redirect_back_or(root_url, notice: 'Page Not Found: Category = '+params[:category_id]+' & Product='+params[:id]+' ')
    else
      add_breadcrumb @category.name, @category
      add_breadcrumb @product.name, category_product_path

      if @product.parents.size > 0

      end
      @product.updateViewCount
      @cart_items = current_cart.cart_items
      @served_product_variants = @product.product_variants.served_at(current_location)
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
      @category = Category.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :image, :nature, :price, :description, :meta_description, :meta_keyword, :views, :active)
    end
    
    def sort_column
        Product.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
end
