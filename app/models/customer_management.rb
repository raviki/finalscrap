class CustomerManagement < ActiveRecord::Base

belongs_to :customer
has_one :cart, :foreign_key => "customer_id"
has_many :cart_items,      :through => :cart
has_many :products,        :through => :cart_items

has_many :addresses,       :foreign_key => "user_id"

has_one :customer_group,  :through => :customer
has_one :customer_lead,   :through => :customer

has_many :orders,         :through => :customer          
has_many :vouchers,       :through => :customer_group



include BCrypt
 validates :name, presence: true, length: { maximum: 50 }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
validates :password, presence: true
validates_confirmation_of :password, on: :create
validates_presence_of :password_confirmation 
before_save :encrypt
 
def new_remember_token
  @token = SecureRandom.urlsafe_base64
  return @token  
  
end

def update_facebook_omniauth(auth)
  self.provider = auth.provider
  self.uid = auth.uid    
  self.oauth_token = auth.credentials.token
  self.password_confirmation = self.password  
  self.oauth_expires_at = Time.at(auth.credentials.expires_at)
end

def self.from_omniauth(auth)   
   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |customerManagement|
      customerManagement.provider = auth.provider
      customerManagement.uid = auth.uid
      customerManagement.name = auth.info.name  
      customerManagement.password = "0"  
      customerManagement.password_confirmation = "0"
      customerManagement.email = auth.extra.raw_info.email
      customerManagement.oauth_token = auth.credentials.token
      customerManagement.oauth_expires_at = Time.at(auth.credentials.expires_at)      
      customerManagement.save
    end
end

def encrypt_token(token)
  return Digest::SHA1.hexdigest(token.to_s)
end  

def add_to_cart(product_id)
    cart.find_or_create_by_customer_id(self.id)
    products.find_or_create_by_cart_id_and_product_id(cart.id, product_id)
end

def send_password_reset
  self.password_reset_token = SecureRandom.urlsafe_base64
  self.password_reset_sent_at = Time.zone.now
  save(:validate => false)
  UserMailer.password_reset(self).deliver
end

   ## Auto generated code using java @ Ravi
  ## Begin

  def self.admin_grid(params = {}, active_state = nil)
    grid = id_filter(params[:id]).
          name_filter(params[:name]).
          email_filter(params[:email]).
          customer_id_filter(params[:customer_id]).
          provider_filter(params[:provider])
  end


  private


    def self.id_filter(id)
      if id.present?
        where("customer_managements.id = ?", id)
      else
        all
      end
    end

    def self.name_filter(name)
      if name.present?
        where("customer_managements.name LIKE ?","%#{name}%")
      else
        all
      end
    end

    def self.email_filter(email)
      if email.present?
        where("customer_managements.email LIKE ?","%#{email}%")
      else
        all
      end
    end

    def self.customer_id_filter(customer_id)
      if customer_id.present?
        where("customer_managements.customer_id = ?", customer_id)
      else
        all
      end
    end

    def self.provider_filter(provider)
      if provider.present?
        where("customer_managements.provider LIKE ?","%#{provider}%")
      else
        all
      end
    end

  ## Auto generated code using java @ Ravi
  ## end

def encrypt
  self.password = BCrypt::Password.create(self.password, :cost => 15)
end

end
