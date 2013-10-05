class Store < ActiveRecord::Base
  
  has_many :store_to_products
  has_many :products,              :through => :store_to_products
  
  has_many :orders
  
  def update_product_map(product_id, price_value) 
      @store_to_product = store_to_products.find_or_create_by_store_id_and_product_id(self.id, product_id)
      @store_to_product.update_columns(price: price_value) 
      @store_to_product.save
  end
  
  def delete_product_map(product_id) 
    store_to_products.find_by_store_id_and_product_id(self.id, product_id).destroy   
  end
  
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
          name_filter(params[:name]).
          contact_name_filter(params[:contact_name]).
          address_filter(params[:address]).
          pin_filter(params[:pin]).
          review_filter(params[:review]).
          rating_filter(params[:rating]).
          active_filter(params[:active])
  end

  private


    def self.id_filter(id)
      if id.present?
        where("stores.id = ?", id)
      else
        all
      end
    end

    def self.name_filter(name)
      if name.present?
        where("stores.name LIKE ?","%#{name}%")
      else
        all
      end
    end

    def self.contact_name_filter(contact_name)
      if contact_name.present?
        where("stores.contact_name LIKE ?","%#{contact_name}%")
      else
        all
      end
    end

    def self.address_filter(address)
      if address.present?
        where("stores.address LIKE ?","%#{address}%")
      else
        all
      end
    end

    def self.pin_filter(pin)
      if pin.present?
        where("stores.pin = ?", pin)
      else
        all
      end
    end

    def self.review_filter(review)
      if review.present?
        where("stores.review LIKE ?","%#{review}%")
      else
        all
      end
    end

    def self.rating_filter(rating)
      if rating.present?
        where("stores.rating = ?", rating)
      else
        all
      end
    end

    def self.active_filter(active)
      if active.present? and active
        where("stores.active")
      else
        all
      end
    end

  ## Auto generated code using java @ Ravi
  ## end
  
end
