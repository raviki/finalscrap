class Admin::Customers::CustomersController < AdminController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :add_to_cart, :create_order, :update_customer_lead_id, :update_customer_group_id,:add_products2checklist,:add_customer_info]
  after_action :log, only: [:update, :destroy, :add_to_cart, :create_order, :update_customer_lead_id, :update_customer_group_id, :add_customer_info,:add_products2checklist]

  # GET /customers
  # GET /customers.json
  def index
    @customers = CustomerManagement.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customers = CustomerManagement.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
                                              
  if params[:add_products_checklist].present? 
     @products = Product.order(sort_column + " " + sort_direction)
     @add_products_checklist = true
   end
   
   puts "-----@customers.@customers.id = #{@customer.customer_id}"
   
  end

  # GET /customers/new
  def new
    @customer = CustomerManagement.new
  end
  
  def add_customer_info    
    @customer_info = Customer.create_new(params)
    if @customer_info
      @customer.update_columns(customer_id: @customer_info.id)
    end
    redirect_to action: "show"
  end
  
  def add_products2checklist
    @cart = Cart.find_or_create_by(:customer_id => @customer.id)
    if params[:select].present?
      params[:select].each do |productId|
       if params[:quantity][productId].to_i > 0
         @cart_item = CartItem.find_or_create_by(:cart_id => @cart.id, :product_id => params[:cart_item][productId])
         @product_variant = ProductVariant.find(params[:cart_item][productId])
         @cart_item.update_attributes(:quantity => params[:quantity][productId], :price => @product_variant.price)
       else          
          if @alert
            @alert= "#{@alert} <br>"          
          end
          @alert = "#{@alert} Product:#{productId} Quanity has to be a number #{productId} Value: #{params[:quantity][productId.to_i-1]}"
        end
      end
   end
   redirect_to({action: "show"}, {alert: @alert})
  end

  # GET /customers/1/edit
  def edit
  end
  
  def add_to_cart
    if params[:product_id].present?    
      @customer.add_to_cart(params[:product_id])
    end
   redirect_to action: "show"
  end
  

  # POST /customers
  # POST /customers.json
  def create
    @customer = CustomerManagement.new(customer_params)

    respond_to do |format|
      if @customer.save
        @customer_info = Customer.new
        @customer_info.save
        @customer.update_attributes(:customer_id => @customer_info.id)
        format.html { redirect_to admin_customers_customers_url, notice: 'Customer was successfully created.' }
        format.json { render action: 'show', status: :created, location: @customer }
      else
        format.html { render action: 'new' }
        format.json { render json: admin_customers_customers_url.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_customer_group_id
    store_location()
    if params[:customer_group_id].present?
      if @customer.customer_id 
        @customer_info = Customer.find(@customer.customer_id)
        if @customer_info.size > 0
          @customer.update_columns(customer_group_id: params[:customer_group_id])
        end
      end
    end 
    redirect_back_or(admin_customers_customers_url)
  end
  
    def update_customer_lead_id
    store_location()
    if params[:customer_lead_id].present?
      if @customer.customer_id 
        @customer_info = Customer.find(@customer.customer_id)
        if @customer_info.size > 0
          @customer.update_columns(customer_lead_id: params[:customer_lead_id])
        end
      end
    end 
    redirect_back_or(admin_customers_customers_url)
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to action: 'show', notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: admin_customers_customers_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = CustomerManagement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer_management).permit(:name, :password, :password_confirmation, :email, :customer_id, :remember_token, :password_digest, :provider, :uid, :oauth_token, :oauth_expires_at, :password_reset_token, :password_reset_sent_at, :contact_no, :add_line1, :add_line2, :city, :pin, :wishlist, :customer_group_id, :customer_lead_id)
    end
    def sort_column
        CustomerManagement.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
