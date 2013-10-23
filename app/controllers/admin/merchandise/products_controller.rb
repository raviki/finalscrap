class Admin::Merchandise::ProductsController < AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :toggle_active]
  helper_method :sort_column, :sort_direction
  after_action :log, only: [:update, :destroy, :toggle_active]

  # GET /products
  # GET /products.json
  def index
    
    @products = Product.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
    if params[:show_search].present?
      @show_search = true
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @products = Product.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
    
  end
  
  def select_page
     @products = Product.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)  
     @destnation_page = request.env["HTTP_REFERER"] 
     
  end
  
  def toggle_active
    store_location()
    @product = Product.find(params[:id])
    @product.toggle_active
    redirect_back_or(admin_merchandise_products_url)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    store_location()
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_back_or(admin_merchandise_products_url, notice: 'Product was successfully created.') }
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
        format.html { redirect_to action: 'show', notice: 'Product was successfully updated.' }
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
      format.html { redirect_to admin_merchandise_products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :image, :price, :description, :meta_description, :meta_keyword, :views, :active)
    end
    
    def sort_column
        Product.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
