
class Users::ManagementsController < ApplicationController
  before_action :set_users_management, only: [:show, :edit, :update, :destroy]

  # GET /users/managements
  # GET /users/managements.json
  def index
    @users_managements = Users::Management.all
  end

  # GET /users/managements/1
  # GET /users/managements/1.json
  def show
  end

  # GET /users/managements/new
  def new
    @users_management = Users::Management.new
  end

  # GET /users/managements/1/edit
  def edit
  end

  # POST /users/managements
  # POST /users/managements.json
  def create
    @users_management = Users::Management.new(users_management_params)
    puts "SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS"
    respond_to do |format|
      if @users_management.save
        format.html { redirect_to sessions_path, notice: 'Management was successfully created.' }
        format.json { render action: 'show', status: :created, location: @users_management }
      else
        format.html { render action: 'new' }
        format.json { render json: @users_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/managements/1
  # PATCH/PUT /users/managements/1.json
  def update
    respond_to do |format|
      if @users_management.update(users_management_params)
        format.html { redirect_to @users_management, notice: 'Management was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @users_management.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/managements/1
  # DELETE /users/managements/1.json
  def destroy
    @users_management.destroy
    respond_to do |format|
      format.html { redirect_to users_managements_url }
      format.json { head :no_content }
    end
  end

  public
    # Use callbacks to share common setup or constraints between actions.
    def set_users_management
      @users_management = Users::Management.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def users_management_params
      params.require(:users_management).permit(:name, :password, :email, :user_id, :password_confirmation)
    end
end
