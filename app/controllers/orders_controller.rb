class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    require_user()
    add_breadcrumb "Orders", orders_path
    
    if current_user
      @order = Order.find_by_customer_id_and_active(current_user.id,true)                                     
      @past_orders = Order.admin_grid(params,current_user.id,true, false).order(sort_column + " " + sort_direction).
                                          paginate(:page => pagination_page, :per_page => pagination_rows)
    end 
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    require_user()
    add_breadcrumb "Orders", orders_path
    add_breadcrumb @order.display_id, order_path
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
    @customer = CustomerManagement.find(order_params[:customer_id])
    if @customer.cart.address_id
      if @customer.cart_items.length > 0 
        location_same = false
        if @customer.cart.address.city.downcase == current_location.downcase
          location_same = true  
        end
        
        serve_all = true
        
        if !location_same
          @extra_cart_items = ""
          @customer.cart_items.each do |cart_item|  
            if !((!cart_item.product_variant.location) || cart_item.product_variant.location == "")
              @temp_item = ProductVariant.where(:product_id => cart_item.product_variant.product_id, :location => @customer.cart.address.city, :value => cart_item.product_variant.value).first
              if @temp_item
                cart_item.update_columns(product_id: @temp_item.id, price: (@temp_item.price + (cart_item.include_service ? @temp_item.service_price : 0)))  
              else
                @extra_cart_items = @extra_cart_items + " & " + cart_item.product.name
                serve_all = false
              end 
            end 
          end    
        end
        
        if location_same || serve_all
          @order = Order.find_or_create_by(:customer_id => order_params[:customer_id],:active => true)        
          @customer.cart_items.each do |cart_item|      
            @order_to_product = OrderToProduct.where(:product_id => cart_item.product_id, :order_id => @order.id).first_or_create
            @order_to_product.update_price_quantity(cart_item.unit_price, cart_item.quantity,cart_item.include_service)
            cart_item.delete       
          end
          @order.save
          @order.update_columns(address_id: @customer.cart.address_id, customer_id: @customer.id, active: true, additional_info: order_params[:additional_info],appointment_time: @customer.cart.appointment_time)
          @customer.cart.delete      
          @customer.send_order_confirmation_mail(@order)
          redirect_to action: 'show', id: @order
        else
          redirect_back_or(root_url, notice: @extra_cart_items+" can not be served at #{@customer.cart.address.city}")
        end 
      else
        redirect_back_or(root_url, notice: 'Empty Cart.')
      end
    else
      redirect_back_or(root_url, notice: 'Kindly select service address')
    end 
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
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
      params.require(:order).permit(:customer_id, :voucher_id, :payment_id, :discount, :additional_info, :discount_message, :appointment_date, :duration_inHrs, :active)
    end
    
    def sort_column
        Product.column_names.include?(params[:sort]) ? params[:sort] : "appointment_date"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
