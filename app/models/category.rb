class Category < ActiveRecord::Base
 
  has_many :category_to_products
  has_many :products,             :through => :category_to_products
  has_many :activeProducts,   -> { where(active: true) },    :source => :product,   :class_name => "Product",  :through => :category_to_products
  
  validates :image, :presence => true
  validates :description, :length => {:maximum =>300}, :presence => true
  
  def toggle_active
    if self.active == true
      self.active = false
    else
      self.active = true
    end
  end
  
  
  ## Auto generated code using java @ Ravi
  ## Begin

  def self.admin_grid(params = {}, active_state = nil)
    grid = id_filter(params[:id]).
          name_filter(params[:name]).
          image_filter(params[:image]).
          description_filter(params[:description]).
          active_filter(active_state)
  end


  private


    def self.id_filter(id)
      if id.present?
        where("categories.id = ?", id)
      else
        all
      end
    end

    def self.name_filter(name)
      if name.present?
        where("categories.name LIKE ?","%#{name}%")
      else
        all
      end
    end

    def self.image_filter(image)
      if image.present?
        where("categories.image LIKE ?","%#{image}%")
      else
        all
      end
    end

    def self.description_filter(description)
      if description.present?
        where("categories.description LIKE ?","%#{description}%")
      else
        all
      end
    end

    def self.active_filter(active)
      puts "---------active filter"
      if active.present? and active
        puts "---------active filter yes"
        where("categories.active")
      else
        puts "---------active filter no"
        all
      end
    end

  ## Auto generated code using java @ Ravi
  ## end
  
end
