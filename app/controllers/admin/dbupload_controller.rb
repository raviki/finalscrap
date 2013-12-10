class Admin::DbuploadController < AdminController
  
  def index
    require 'csv'
    @insert_status = false
    if params[:export_file].present?
      CSV.foreach(params[:export_file], :headers => true , :encoding => 'ISO-8859-1') do |row|
        if row['name'] && row['name'] != ""
          @product = Product.find_or_create_by(name: row['name'].gsub(/<\/?[^>]*>/, '').strip)
          @product.update_attributes( :image  =>  row['image'],
          :description => row['description'],
          :meta_description=> row['meta_description'],
          :active => row['active'],
          :nature => row['nature'],
          :video => row['video'],
          :variant_name => row['variant_name'],
          :menu_parent => row['menu_parent'],
          :how2fix => row['how2fix'])
          @product.save
          
          if @product
            @insert_status = true
            @pre_product = @product
          else 
             @insert_status = false 
             @insert_error = @insert_error+row['name']+" "
          end
        end
        if (@product  || (row['price'] && row['price'] != "" && @insert_status))
          
          @productVariant = ProductVariant.find_or_create_by(:product_id =>  @product? @product.id: @pre_product.id,
                              :value => row['value'])              
          @productVariant.save  
          @productVariant.update_attributes(:price => ((row['price'].to_f > 0)?  row['price'].to_f : 0))
        end
        
       @product = nil
      end
    end

    if @insert_error && @insert_error != ""
      flash[:alert] = "Following Products are not inserted Properly: "+@insert_error
    end   
  end 
end
