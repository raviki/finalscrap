class Admin::Customers::CustomerLeadsController < AdminController
  before_action :set_customer_lead, only: [:show, :edit, :update, :destroy]

  # GET /customer_leads
  # GET /customer_leads.json
  def index
    @customer_leads = CustomerLead.admin_grid(params).order(sort_column + " " + sort_direction).
                                              paginate(:page => pagination_page, :per_page => pagination_rows)
  end

  # GET /customer_leads/1
  # GET /customer_leads/1.json
  def show
  end

  # GET /customer_leads/new
  def new
    @customer_lead = CustomerLead.new
  end

  # GET /customer_leads/1/edit
  def edit
  end

  # POST /customer_leads
  # POST /customer_leads.json
  def create
    @customer_lead = CustomerLead.new(customer_lead_params)

    respond_to do |format|
      if @customer_lead.save
        format.html { redirect_to admin_customers_customer_leads_url, notice: 'Customer lead was successfully created.' }
        format.json { render action: 'show', status: :created, location: @customer_lead }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer_lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_leads/1
  # PATCH/PUT /customer_leads/1.json
  def update
    respond_to do |format|
      if @customer_lead.update(customer_lead_params)
        format.html { redirect_to action: 'show', notice: 'Customer lead was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer_lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_leads/1
  # DELETE /customer_leads/1.json
  def destroy
    @customer_lead.destroy
    respond_to do |format|
      format.html { redirect_to customer_leads_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_lead
      @customer_lead = CustomerLead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_lead_params
      params.require(:customer_lead).permit(:type_name, :description)
    end
    
    def sort_column
        CustomerLead.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
