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
  
  def self.find(input)
    if input.to_i != 0
      super
    else
      find_by_name(input)
    end
  end
  
  def to_param
    "#{name}"
  end
  
  def self.standard_search(text)
    if text.present?
      keys=text.split(" ")
      @query = ""
      keys.each do |key|
       if @query != ""
          @query=@query+" or " 
        end
        @query=@query+"categories.name LIKE '%#{key}%'"
      end
      grid = where(@query)
    else
      all
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
      if active.present? and active
        where("categories.active")
      else
        all
      end
    end

  ## Auto generated code using java @ Ravi
  ## end
  
end
