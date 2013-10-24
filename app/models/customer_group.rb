class CustomerGroup < ActiveRecord::Base
  
  has_many :customers
  has_many :vouchers
  has_many :customer_managements, :through => :customers
  validates :description, :length => {:maximum =>300}, :presence => true
  
  ## Auto generated code using java @ Ravi
  ## Begin


  def self.admin_grid(params = {}, active_state = nil)
    grid = id_filter(params[:id]).
          description_filter(params[:description])
  end


  private


    def self.id_filter(id)
      if id.present?
        where("customer_groups.id = ?", id)
      else
        all
      end
    end

    def self.description_filter(description)
      if description.present?
        where("customer_groups.description LIKE ?","%#{description}%")
      else
        all
      end
    end


  ## Auto generated code using java @ Ravi
  ## end
  
end
