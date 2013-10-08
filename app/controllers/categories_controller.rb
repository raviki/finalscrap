class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.admin_grid(params,true).order(sort_column + " " + sort_direction).
                                          paginate(:page => pagination_page, :per_page => pagination_rows)
  end
  
  def facebook_callback
    @categories = Category.admin_grid(params,true).order(sort_column + " " + sort_direction).
                                          paginate(:page => pagination_page, :per_page => pagination_rows)
    
    @customerManagement = CustomerManagement.where(:email => env["omniauth.auth"].extra.raw_info.email).first
    if @customerManagement
      @customerManagement.update_facebook_omniauth(env["omniauth.auth"])
      @customerManagement.save
      session[:customer_id] = @customerManagement.id
    else
      @customerManagement = CustomerManagement.from_omniauth(env["omniauth.auth"])
      session[:customer_id] = @customerManagement.id
    end 
      
    redirect_to action: "index"
    
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
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
