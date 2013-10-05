class Admin::History::SalesController < AdminController
 before_action :set_order_log, only: [:show, :edit, :update, :destroy]

  # GET /order_logs
  # GET /order_logs.json
  def index
    @order_logs = OrderLog.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
  end

  # GET /order_logs/1
  # GET /order_logs/1.json
  def show
  end

  # GET /order_logs/new
  def new
    @order_log = OrderLog.new
  end

  # GET /order_logs/1/edit
  def edit
  end

  # POST /order_logs
  # POST /order_logs.json
  def create
    @order_log = OrderLog.new(order_log_params)

    respond_to do |format|
      if @order_log.save
        format.html { redirect_to admin_history_sales_url, notice: 'Order log was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order_log }
      else
        format.html { render action: 'new' }
        format.json { render json: @order_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_logs/1
  # PATCH/PUT /order_logs/1.json
  def update
    respond_to do |format|
      if @order_log.update(order_log_params)
        format.html { redirect_to admin_history_sales_url, notice: 'Order log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_logs/1
  # DELETE /order_logs/1.json
  def destroy
    @order_log.destroy
    respond_to do |format|
      format.html { redirect_to order_logs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_log
      @order_log = OrderLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_log_params
      params.require(:order_log).permit(:user_id, :order_id, :voucher_id, :payment_id)
    end
    
    def sort_column
        OrderLog.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
