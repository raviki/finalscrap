class CustomerManagement < ActiveRecord::Base
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |customerManagement|
      customerManagement.provider = auth.provider
      customerManagement.uid = auth.uid
      customerManagement.name = auth.info.name      
      @customer = Customer.where(:id => customerManagement.customer_id).first_or_create
      @customer.first_name = auth.info.name
      @customer.save
      customerManagement.customer_id = @customer.id
      customerManagement.oauth_token = auth.credentials.token
      customerManagement.oauth_expires_at = Time.at(auth.credentials.expires_at)
      customerManagement.save!
    end
  end
  
end
