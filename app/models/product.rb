class Product < ActiveRecord::Base
  has_many :store_to_products
  has_many :stores,                 :through => :store_to_products
  
  has_many :product_variants
  has_many :cart_items,             :through => :product_variants
  
  has_many :category_to_products
  has_many :categories,             :through => :category_to_products
  
  has_one :parent_product,   -> { where(id: self.parent) }
  
  has_many :product_to_tools
  has_many :tools,                  :through => :product_to_tools
  
  has_many :parent_maps,   class_name: "ProductToTool", :foreign_key => "tool_id" 
  has_many :parents,  :through => :parent_maps, :source => :product    
  
  
  belongs_to :parent, class_name: "Product"
  
  has_many :order_to_products
  has_many :orders,                 :through => :order_to_products
  
  validates :name,                  :presence => true,          :length => { :maximum => 165 }
  validates :image,                 :presence => true
  validates :description,           :presence => true
  before_save :create_permalink
 
  
  def user_location
    return ApplicationController.helpers.current_location
  end
  
  def toggle_active
    if self.active == true
      self.active = false
    else
      self.active = true
    end
    self.save
  end
  
  def to_param
    permalink
  end
    
  def self.find(input)
    if input.to_i != 0
      super
    else
      find_by_permalink(input)
    end
  end
  
  def self.standard_search(text)
    if text.present?
      keys=text.split(" ")
      @query = ""
      keys.each do |key|
       if @query != ""
          @query=@query+" or " 
        end
        @query=@query+"LOWER(products.name) LIKE '%#{key.downcase}%'"
      end
      grid = where(@query)
    else
      all
    end
  end
  
  def updateViewCount
    self.views = self.views.to_i + 1;
    self.save
  end

  ## Auto generated code using java @ Ravi
  ## Begin 

  def self.admin_grid(params = {}, active_state = nil, text = nil)
    grid = id_filter(params[:id]).
          name_filter(params[:name])
          price_filter(params[:price]).
          description_filter(params[:description]).
          active_filter(active_state).
          parent_filter(params[:parent]).
          standard_search(text)
  end

  private
     
   def create_permalink
    self.permalink = name.downcase.parameterize
   end

   def self.active_filter(active_state)
      if active_state.present? || active_state
        where("customers.active")
      else
        all
      end     
    end
    
    def self.id_filter(id)
      if id.present?
        where("products.id = ?", id)
      else
        all
      end
    end
    
    def self.parent_filter(id)
      if id.present?
        where("products.parent = ?", id)
      else
        all
      end
    end

    def self.name_filter(name)
      if name.present?
        where("products.name LIKE ?","%#{name}%")
      else
        all
      end
    end

    def self.price_filter(price)
      if price.present?
        where("products.price = ?", price)
      else
        all
      end
    end

    def self.description_filter(description)
      if description.present?
        where("products.description LIKE ?","%#{description}%")
      else
        all
      end
    end

    def self.active_filter(active)
      if active.present? and active
        where("products.active")
      else
        all
      end
    end

  ## Auto generated code using java @ Ravi
  ## end
  
end
