module ApplicationHelper
  def site_name
    I18n.t(:company)
  end
  
  def contact_number
    I18n.t(:company_phone)
  end 
  
  def sortable(column, title = nil)  
    title ||= column.titleize  
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"  
    link_to title, :sort => column, :direction => direction  
  end
  
  def deparameterize(the_string)
    result = the_string.to_s.dup
    result.downcase.gsub(/ +/,'_')
    return result
  end
end
