class Admin::Partners::StoresController < AdminController
 before_action :set_store, only: [:show, :edit, :update, :destroy, :update_product_map]
 after_action :log, only: [:update, :destroy, :update_product_map]

  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
    if params[:show_search].present?
      @show_search = true
    end
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
   @stores = Store.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
    if params[:update_products].present? 
     @products = Product.order(sort_column + " " + sort_direction)
     @update_products = true
   end 
  end
  
  def toggle_active    
    @store = Store.find(params[:id])
    @store.toggle_active
    @store.save
    redirect_back_or(admin_partners_stores_url)
  end
  
  def update_product_map    
    if params[:select].present?
      params[:select].each do |productId|
        if params[:price][productId.to_i].to_i > 0
          @store.update_product_map(productId,params[:price][productId.to_i])
        else
          if @alert
            @alert= "#{@alert} <br>"          
          end
          @alert = "#{@alert} Product:#{productId} Pirce has to be a number"
        end
      end
   end
   redirect_to({action: "show"}, {alert: @alert})
  end
  
  def delete_product_map
    if params[:product_id].present?
      @store = Store.find(params[:id])
      @store.delete_product_map(params[:product_id])
    end
    redirect_to action: "show"
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end

  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to admin_partners_stores_url, notice: 'Store was successfully created.' }
        format.json { render action: 'show', status: :created, location: @store }
      else
        format.html { render action: 'new' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to action 'show', notice: 'Store was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json
  def destroy
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :contact_name, :contact_no, :address, :pin, :review, :rating, :active, :new_product_map => ['product_id', 'price'], :delete_product_map => ['product_id'])
    end
 
    def sort_column
        Store.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
