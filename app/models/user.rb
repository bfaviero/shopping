class User < ActiveRecord::Base
	has_many :carts
	has_secure_password
	attr_accessible :email, :password, :password_confirmation, :first_name, :temp, :seller
	validates_uniqueness_of :email

	def get_cart
		Cart.where(:user_id => self.id, :active => true)
	end
end
