require 'bcrypt'
class Users::Management < ActiveRecord::Base
include BCrypt
 validates :name, presence: true, length: { maximum: 50 }
 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
 validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
validates :password, presence: true
puts" Here ?"
validates_confirmation_of :password, on: :create
validates_presence_of :password_confirmation 
before_save :encrypt
 
def new_remember_token
  @token = SecureRandom.urlsafe_base64
  return @token  
  
end

def encrypt_token(token)
  return Digest::SHA1.hexdigest(token.to_s)
end  

private
def encrypt
  self.password = BCrypt::Password.create(self.password, :cost => 15)
end


end
