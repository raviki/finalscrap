class Admin::Merchandise::CategoriesController < AdminController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :new_product_map, :delete_product_map, :toggle_active]
  after_action :log, only: [:update, :destroy, :new_product_map, :delete_product_map, :toggle_active]

  # GET /categories
  # GET /categories.json
   def index
    @categories = Category.admin_grid(params).order(sort_column + " " + sort_direction).
                                          paginate(:page => pagination_page, :per_page => pagination_rows)
  end
  
   def toggle_active    
    store_location()
    @category.toggle_active
    @category.save
    redirect_back_or(admin_merchandise_categories_url)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show    
    @categories = Category.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
     
   
   if params[:show_products].present? 
     @products = Product.order(sort_column + " " + sort_direction)
     @show_products = true
   end   
  end

  # GET /categories/new
  def new
    @category = Category.new
  end
  
  def new_product_map
    if params[:product_id].present?    
      @category.new_product_map(params[:product_id])
    end
    if params[:select].present?
      params[:select].each do |productId|
        CategoryToProduct.where(:category_id => @category.id, :product_id => productId).first_or_create
      end
    end
    redirect_to action: "show"
  end
  
  def delete_product_map
    if params[:product_id].present?
      @categoryToProduct = CategoryToProduct.where(:category_id => @category.id, :product_id => params[:product_id])
      if @categoryToProduct.first
        @categoryToProduct.first.destroy
      end
    end
    redirect_to action: "show"
  end
  
  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    trim_name = category_params[:name].strip
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        @category.update_attributes(:name => trim_name)
        format.html { redirect_to admin_merchandise_categories_url, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: admin_merchandise_categories_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to  action: "show", notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :image, :description, :active, :new_product_map => ['product_id', 'select'], :delete_product_map => ['id', 'product_id'])
    end
    
     def sort_column
        Category.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    
end
