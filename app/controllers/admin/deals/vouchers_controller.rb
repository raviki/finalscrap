class Admin::Deals::VouchersController < AdminController
before_action :set_voucher, only: [:show, :edit, :update, :destroy, :toggle_active]

  # GET /vouchers
  # GET /vouchers.json
  def index
    @vouchers = Voucher.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
    if params[:show_search].present?
      @show_search = true
    end
  end
  
  def toggle_active
    store_location()
    @voucher = Voucher.find(params[:id])
    @voucher.toggle_active
    redirect_back_or(admin_deals_vouchers_url)
  end
  
   def update_customer_group_id
    store_location()
    if params[:customer_group_id].present?
      @voucher = Voucher.find(params[:id])
      @voucher.update_columns(customer_group_id: params[:customer_group_id])
    end
    redirect_back_or(admin_deals_vouchers_url)
  end

  # GET /vouchers/1
  # GET /vouchers/1.json
  def show
  end

  # GET /vouchers/new
  def new
    @voucher = Voucher.new
  end

  # GET /vouchers/1/edit
  def edit
  end

  # POST /vouchers
  # POST /vouchers.json
  def create
    @voucher = Voucher.new(voucher_params)

    respond_to do |format|
      if @voucher.save
        format.html { redirect_to admin_deals_vouchers_url, notice: 'Voucher was successfully created.' }
        format.json { render action: 'show', status: :created, location: @voucher }
      else
        format.html { render action: 'new' }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vouchers/1
  # PATCH/PUT /vouchers/1.json
  def update
    respond_to do |format|
      if @voucher.update(voucher_params)
        format.html { redirect_to action: 'show', notice: 'Voucher was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vouchers/1
  # DELETE /vouchers/1.json
  def destroy
    @voucher.destroy
    respond_to do |format|
      format.html { redirect_to vouchers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voucher
      @voucher = Voucher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voucher_params
      params.require(:voucher).permit(:description, :customer_group_id, :type_name, :value, :validity_till, :active)
    end
    
    def sort_column
        Voucher.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
