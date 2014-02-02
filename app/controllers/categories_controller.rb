class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    if cookies[:lat_lon]
      lat_lng = cookies[:lat_lon]
      lat = lat_lng.split("|").first.to_f
      lng = lat_lng.split("|").second.to_f
      puts "lat long #{lat}  #{lng}" 
      @location = Geocoder.search("#{lat},#{lng}")
 
      if @location[0]
        cookies.permanent[:current_location_city] = @location[0].city
      end
    end
    
    if params[:key].present?
      if params[:select].present?
        redirect_to :action => "show", :id => params[:select], :key => params[:key]
      else
        redirect_to :action => "show", :id => "all" , :key => params[:key]
      end
    else 
      if params[:select].present?
        redirect_to :action => "show", :id => params[:select], :key => ""
      end
    end
    @root_url = "yes"
    @categories = Category.admin_grid(params,true).order(sort_column + " " + sort_direction).
                                          paginate(:page => pagination_page, :per_page => pagination_rows)
   end

  # GET /categories/1
  # GET /categories/1.json
  def show   
    if params[:key].present?
      add_breadcrumb params[:key], category_path

      if @category   
        @show_request = true  
        is_search_name = true
        if params[:is_submenu].present?
          is_search_name = false
        end
        @products = @category.activeProducts.standard_search(params[:key], !(params[:is_submenu].present?)).
                                    paginate(:page => pagination_page, :per_page => pagination_rows)

      else
        @temp_category = Category.find_by_name(params[:key])
        if @temp_category
          redirect_to @temp_category
        end
        @products = Product.standard_search(params[:key]).paginate(:page => pagination_page, :per_page => pagination_rows)
      end
    else
      if @category
        add_breadcrumb @category.name, @category
        @show_request = true
        if params[:tools]
          @products = @category.tools.paginate(:page => pagination_page, :per_page => pagination_rows)
        else
          @products = @category.activeProducts.order( "id  asc").paginate(:page => pagination_page, :per_page => pagination_rows)
        end
      else
        store_location()
        redirect_back_or(root_url, notice: 'Page Not Found: Category = '+params[:id]) 
      end  
    end
    
    @categories = Category.all
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end
  
  def update_location
    store_location()
    if params[:location].present?
      set_location(params[:location])
      update_cart_items
    end
    redirect_back_or(root_url) 
  end
  
  def standard_search        
    if params[:text].present? 
       @category = Category.standard_search(params[:text])      
    end    
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
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
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
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
      params.require(:category).permit(:name, :image, :description, :active)
    end
    def sort_column
        Category.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
