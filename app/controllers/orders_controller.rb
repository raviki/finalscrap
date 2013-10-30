class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
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
    if @customer.cart_items.length > 0 
      @order = Order.find_or_create_by_customer_id(params[:customer_id])
      @customer.cart_items.each do |cart_item|      
        @order_to_product = OrderToProduct.where(:product_id => cart_item.product_id, :order_id => @order.id).first_or_create
        @order_to_product.update_price_quantity(cart_item.price, cart_item.quantity)
        cart_item.delete       
      end
      @customer.cart.delete
      @order.save
      redirect_to action: 'show', id: @order.id
    else
      redirect_back_or(products_url, notice: 'Empty Cart.')
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
      params.require(:order).permit(:customer_id, :voucher_id, :payment_id, :discount, :discount_message, :appointment_date, :duration_inHrs, :active)
    end
end
