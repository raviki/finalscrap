class CustomerManagement < ActiveRecord::Base

has_one :cart, :foreign_key => "customer_id"
has_many :cart_items,      :through => :cart
has_many :products,        :through => :cart_items

has_many :addresses,       :foreign_key => "user_id"

belongs_to :customer_group, :foreign_key => "customer_id"
belongs_to :customer_lead, :foreign_key => "customer_id"

has_many :orders, :foreign_key => "customer_id"                 
has_many :vouchers,       :through => :customer_group

has_many :reviews

include BCrypt
 validates :name, presence: true, length: { maximum: 50 }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 validates :email,  format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }, :unless => lambda{ |user| user.email.blank? }
validates :password, presence: true
validates_confirmation_of :password, on: :create
validates_presence_of :password_confirmation, :unless => lambda{ |user| user.password_confirmation.blank? } 
validates :role, presence: true

before_save :encrypt


has_many :addresses, foreign_key: "user_id"

 
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

def first_name
  return self.name.split(' ').first  
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

def send_welcome_message
  if self.email && self.email != ""
    UserMailer.welcome_mail(self).deliver
  elsif ApplicationController.helpers.is_mobile_number(self.mobile_number)
    ApplicationController.helpers.sms_welcome_message(self) 
  end
end

def send_password_reset_4mobile
  new_password = 100000 + rand(99999)
  self.password = new_password
  self.password_reset_token = SecureRandom.urlsafe_base64
  self.password_reset_sent_at = Time.zone.now
  self.provider = "self_mobile_reset"
  self.save
  ApplicationController.helpers.sms_password_reset(self, new_password)
end

def send_order_confirmation_mail(order)
  if self.email && self.email != ""
    UserMailer.order_confirmation(self, order).deliver
  end 
end

  ## Auto generated code using java @ Ravi
  ## Begin

  def self.admin_grid(params = {}, active_state = nil)
    grid = id_filter(params[:id]).
          name_filter(params[:name]).
          email_filter(params[:email]).
          mobile_number_filter(params[:mobile_number]).
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
    
    def self.mobile_number_filter(mobile_number)
      if mobile_number.present?
        where("customer_managements.mobile_number LIKE ?","%#{mobile_number}%")
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
