class Customer < ActiveRecord::Base
  
  belongs_to :customer_group
  belongs_to :customer_lead
  
  has_one :customer_management
  has_one :cart,             :through => :customer_management
  has_many :cart_items,      :through => :cart
  has_many :products,        :through => :cart_items
  has_many :reviews

  has_many :orders         
  has_many :vouchers,        :through => :customer_group
  
  
  def add_to_cart(product_id)
    cart.find_or_create_by_customer_id(self.id)
    products.find_or_create_by_cart_id_and_product_id(cart.id, product_id)
  end
  
  def self.create_find4CustomerManager(customerManagement)
    if !customerManagement.customer_id
      @customer = Customer.new
      @customer.first_name = customerManagement.name
      @customer.save
      customerManagement.update_attributes(:customer_id => @customer.id)
    end
    return @customer
  end
  
  def self.create_new(params)
    @customer = Customer.new
    @customer.contact_no = params[:contact_no]
    @customer.add_line1 = params[:add_line1]
    @customer.add_line2 = params[:add_line2]
    @customer.city = params[:city] 
    @customer.pin = params[:pin]
    @customer.customer_group_id = params[:customer_group_id]
    @customer.customer_lead_id = params[:customer_lead_id]
    @customer.save
    return @customer
  end
  
  
  ## Auto generated code using java @ Ravi
  ## Begin

  def self.admin_grid(params = {}, active_state = nil)
    grid = id_filter(params[:id]).
          first_name_filter(params[:first_name]).
          contact_no_filter(params[:contact_no]).
          pin_filter(params[:pin]).
          wishlist_filter(params[:wishlist]).
          customer_group_id_filter(params[:customer_group_id]).
          customer_lead_id_filter(params[:customer_lead_id]).
          active_filter(active_state)
  end


  private

    def self.active_filter(active_state)
      if active_state.present? || active_state
        where("customers.active")
      else
        all
      end     
    end
    
    def self.id_filter(id)
      if id.present?
        where("customers.id = ?", id)
      else
        all
      end
    end

    def self.first_name_filter(first_name)
      if first_name.present?
        where("customers.first_name LIKE ?","%#{first_name}%")
      else
        all
      end
    end

    def self.contact_no_filter(contact_no)
      if contact_no.present?
        where("customers.contact_no = ?", contact_no)
      else
        all
      end
    end

    def self.pin_filter(pin)
      if pin.present?
        where("customers.pin = ?", pin)
      else
        all
      end
    end

    def self.wishlist_filter(wishlist)
      if wishlist.present? and wishlist
        where("customers.wishlist")
      else
        all
      end
    end

    def self.customer_group_id_filter(customer_group_id)
      if customer_group_id.present?
        where("customers.customer_group_id = ?", customer_group_id)
      else
        all
      end
    end

    def self.customer_lead_id_filter(customer_lead_id)
      if customer_lead_id.present?
        where("customers.customer_lead_id = ?", customer_lead_id)
      else
        all
      end
    end


  ## Auto generated code using java @ Ravi
  ## end
  
end
