class Voucher < ActiveRecord::Base
  has_many :orders
  belongs_to :customer_group
  
    def toggle_active
    if self.active == true
      self.active = false
    else
      self.active = true
    end
    self.save
  end
  
    ## Auto generated code using java @ Ravi
  ## Begin

  def self.admin_grid(params = {}, active_state = nil)
    grid = id_filter(params[:id]).
          description_filter(params[:description]).
          customer_group_id_filter(params[:customer_group_id]).
          type_name_filter(params[:type_name]).
          value_filter(params[:value]).
          validity_till_filter(params[:validity_till]).
          active_filter(params[:active])
  end


  private


    def self.id_filter(id)
      if id.present?
        where("vouchers.id = ?", id)
      else
        all
      end
    end

    def self.description_filter(description)
      if description.present?
        where("vouchers.description LIKE ?","%#{description}%")
      else
        all
      end
    end

    def self.customer_group_id_filter(customer_group_id)
      if customer_group_id.present?
        where("vouchers.customer_group_id = ?", customer_group_id)
      else
        all
      end
    end

    def self.type_name_filter(type_name)
      if type_name.present?
        where("vouchers.type_name = ?", type_name)
      else
        all
      end
    end

    def self.value_filter(value)
      if value.present?
        where("vouchers.value = ?", value)
      else
        all
      end
    end

    def self.validity_till_filter(validity_till)
      if validity_till.present?
        where("vouchers.validity_till = ?", validity_till)
      else
        all
      end
    end

    def self.active_filter(active)
      if active.present? and active
        where("vouchers.active")
      else
        all
      end
    end

  ## Auto generated code using java @ Ravi
  ## end
  
end
