class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    if params[:key].present?
      if params[:select].present?
        redirect_to :action => "show", :id => params[:select], :key => params[:key]
      else
        redirect_to :action => "show", :id => "all" , :key => params[:key]
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
      add_breadcrumb "Search", category_path
      if @category       
        @products = @category.activeProducts.standard_search(params[:key])
      else
        @temp_category = Category.find_by_name(params[:key])
        if @temp_category
          redirect_to @temp_category
        end
        @products = Product.standard_search(params[:key])
      end
    else
      if @category
        add_breadcrumb @category.name, category_path
        if params[:tools]
          @products = @category.tools
        else
          @products = @category.activeProducts
        end
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
      @category = Category.find_by_name(params[:id])
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
