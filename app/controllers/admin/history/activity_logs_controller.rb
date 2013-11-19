class Admin::History::ActivityLogsController < AdminController
  def index
    @activities = Activity.admin_grid(params).order(sort_column + " " + sort_direction).
                                          paginate(:page => pagination_page, :per_page => pagination_rows)
  end
  
  private
    def sort_column
        Product.column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
    end

    def sort_direction
        %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end