class Admin::Fulfillments::OrdersController < AdminController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :assign_store]
  after_action :log, only: [:update, :destroy, :assign_store]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.admin_grid(params,params[:customer_id],params[:active]).order(sort_column + " " + sort_direction).
                                          paginate(:page => pagination_page, :per_page => pagination_rows)
    if params[:show_search].present?
      @show_search = true
    end
  end
  
  def toggle_active    
    store_location()
    @order = Order.find(params[:id])
    @order.toggle_active
    @order.save
    redirect_back_or(admin_fulfillments_orders_url)
  end
  
  def assign_store    
    if params[:select].present?      
      params[:select].each do |productId|
        if StoreToProduct.where(:store_id => params[:store][:store_id], :product_id => productId).size > 0
          @order_to_product = OrderToProduct.where(:order_id => @order.id, :product_id => productId).first_or_create
          @order_to_product.update_attributes(:store_id => params[:store][:store_id])
        else
          @error = "Store #{params[:store][:store_id]} does not surve Product #{productId}\n"
        end
      end
    end
    redirect_to({ action: 'show' }, {:notice => @error })
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    if params[:assgn_products].present?
      @assgn_products = true
      @products = @order.products
    end
  end

  def create_order
    store_location()
    @customer = Customer.where(:id => params[:customer_id]).first
    if @customer.cart_items.length > 0 
      @order = Order.find_or_create_by_customer_id(params[:customer_id])
      @customer.cart_items.each do |cart_item|      
        @order_to_product = OrderToProduct.where(:product_id => cart_item.product_id, :order_id => @order.id).first_or_create
        cart_item.delete       
      end
      @customer.cart.delete
      @order.save
      redirect_to action: 'show', id: @order.id
    else
      redirect_back_or(admin_customers_customers_url(@customer), notice: 'Empty Cart.')
    end
  end
  
  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to  action: 'show', notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to action: 'show', notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:customer_id, :voucher_id, :payment_id, :discount, :discount_message, :appointment_date, :duration_inHrs, :active)
    end
    
    def sort_column
        Product.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
