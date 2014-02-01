class Review < ActiveRecord::Base
belongs_to :customer_managements
belongs_to :product
validates :user_id, presence: true

end
