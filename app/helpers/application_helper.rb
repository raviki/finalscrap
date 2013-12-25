module ApplicationHelper
  def site_name
    I18n.t(:company)
  end
  
  
  def contact_number
    I18n.t(:company_phone)
  end 
  
  def meta_keywords_default
    I18n.t(:meta_keywords)
  end
  
  def meta_description_default
    I18n.t(:meta_description)
  end
  
  def title_default
    I18n.t(:title_default)
  end 
  
  Type = {
    TASK: 'task',
    TOOL: 'tool',
    TASKnREADY: 'task not ready',
    TASKwBRAND: 'task vary with brand',
    TOOLnTASK: 'tool and task'
    }
    
  def ProductNature(type)
      return Type[type].to_s  
  end
  
  def is_mobile_feature_present
    if I18n.t(:mobile_feature) == "yes"
      return true
    end
    return false
  end 
  
  def sortable(column, title = nil)  
    title ||= column.titleize  
    direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"  
    link_to title, :sort => column, :direction => direction  
  end
end
