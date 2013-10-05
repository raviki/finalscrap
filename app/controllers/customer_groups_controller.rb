class CustomerGroupsController < ApplicationController
  before_action :set_customer_group, only: [:show, :edit, :update, :destroy]

  # GET /customer_groups
  # GET /customer_groups.json
  def index
    @customer_groups = CustomerGroup.all
  end

  # GET /customer_groups/1
  # GET /customer_groups/1.json
  def show
  end

  # GET /customer_groups/new
  def new
    @customer_group = CustomerGroup.new
  end

  # GET /customer_groups/1/edit
  def edit
  end

  # POST /customer_groups
  # POST /customer_groups.json
  def create
    @customer_group = CustomerGroup.new(customer_group_params)

    respond_to do |format|
      if @customer_group.save
        format.html { redirect_to @customer_group, notice: 'Customer group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @customer_group }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_groups/1
  # PATCH/PUT /customer_groups/1.json
  def update
    respond_to do |format|
      if @customer_group.update(customer_group_params)
        format.html { redirect_to @customer_group, notice: 'Customer group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @customer_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_groups/1
  # DELETE /customer_groups/1.json
  def destroy
    @customer_group.destroy
    respond_to do |format|
      format.html { redirect_to customer_groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_group
      @customer_group = CustomerGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_group_params
      params.require(:customer_group).permit(:description, :permission_level)
    end
end
