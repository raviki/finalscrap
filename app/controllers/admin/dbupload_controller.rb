class Admin::DbuploadController < AdminController
  
  def index
    require 'csv'
    if params[:export_file].present?
      CSV.foreach(params[:export_file], :headers => true , :encoding => 'ISO-8859-1') do |row|

        if row['name'] && row['name'] != ""
          puts "------#{row['name']}"
          @product = Product.find_or_create_by(name: row['name'].gsub(/<\/?[^>]*>/, ''))
          @product.update_attributes( :image  =>  row['image'],
          :description => row['description'],
          :meta_description=> row['meta_description'],
          :active => row['active'],
          :video => row['video'],
          :how2fix => row['how2fix'])
          @product.save
          @pre_product = @product 
          if !@product
             @insert_error = @insert_error+row['name']+" "
          end
        end
        if @product  || (row['Size'] && row['Size'] != "")
          @productVariant = ProductVariant.create(:product_id =>  @product? @product.id: @pre_product.id,
                              :value => row['Size'],
                              :price => row['price'].to_f > 0?  row['price'] : 0)
          @productVariant.save
        end
        @product = nil
      end
    end

    if @insert_error && @insert_error != ""
      flash[:alert] = "following products are not inserted properly: "+@insert_error
    end
    
    
  end 
end
