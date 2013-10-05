class CustomerLead < ActiveRecord::Base
  
  has_many :customers
  validates :description, :length => {:maximum =>300}, :presence => true
  
    ## Auto generated code using java @ Ravi
  ## Begin


  def self.admin_grid(params = {}, active_state = nil)
    grid = id_filter(params[:id]).
          type_name_filter(params[:type_name]).
          description_filter(params[:description])
  end


  private


    def self.id_filter(id)
      if id.present?
        where("customer_leads.id = ?", id)
      else
        all
      end
    end

    def self.type_name_filter(type_name)
      if type_name.present?
        where("customer_leads.type_name LIKE ?","%#{type_name}%")
      else
        all
      end
    end

    def self.description_filter(description)
      if description.present?
        where("customer_leads.description LIKE ?","%#{description}%")
      else
        all
      end
    end


  ## Auto generated code using java @ Ravi
  ## end
  
end
