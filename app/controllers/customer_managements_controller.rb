class CustomerManagementsController < ApplicationController
  before_action :set_customer_management, only: [:show, :edit, :update, :destroy]

  # GET /customer_managements
  # GET /customer_managements.json
  def index
    @customer_managements = CustomerManagement.all
  end

  # GET /customer_managements/1
  # GET /customer_managements/1.json
  def show
  end

  # GET /customer_managements/new
  def new
    @customer_management = CustomerManagement.new
  end

  # GET /customer_managements/1/edit
  def edit
  end

  # POST /customer_managements
  # POST /customer_managements.json
  def create
    @customer_management = CustomerManagement.new(customer_management_params)

    respond_to do |format|
      if @customer_management.save
        format.html { redirect_to @customer_management, notice: 'Customer management was successfully created.' }
        format.json { render action: 'show', status: :created, location: @customer_management }
      else
        format.html { render action: 'new' }
        format.json { render json: @customer_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_managements/1
  # PATCH/PUT /customer_managements/1.json
    def update
    if (params[:customer_management][:old_password] or params[:customer_management][:password_confirmation].blank?)
      @user = current_user
      if @user
        @user_hash = BCrypt::Password.new(@user.password)
        if (@user_hash == params[:customer_management][:old_password] or @user_hash == params[:customer_management][:password])
          flag = true  
        end
      end
    end
    if flag ==true 
        respond_to do |format|
        if @customer_management.update(customer_management_params)
          format.html { redirect_to :back, notice: 'Customer management was successfully updated.' }
          format.json { head :no_content }
        format.js
        else
          format.html { render action: 'edit' }
          format.json { render json: @customer_management.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :back, notice: 'Please re enter correct password'
    end
  end

  # DELETE /customer_managements/1
  # DELETE /customer_managements/1.json
  def destroy
    @customer_management.destroy
    respond_to do |format|
      format.html { redirect_to customer_managements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_management
      @customer_management = CustomerManagement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_management_params
      params.require(:customer_management).permit(:name, :password, :email, :customer_id, :remember_token, :password_digest,:password_confirmation)
    end
end
