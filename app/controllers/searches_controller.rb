class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :destroy]

  # GET /searches
  # GET /searches.json
  def index
    store_location()
    @search = Search.new
    @search.update_columns(keys: params[:keys])
    
    if params[:keys].present?
      
    end
   
    redirect_back_or(admin_search_url)
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'Search was successfully created.' }
        format.json { render action: 'show', status: :created, location: @search }
      else
        format.html { render action: 'new' }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end
end
