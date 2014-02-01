class Review < ActiveRecord::Base
belongs_to customer
belongs_to product
validates :user_id, presence: true

end
