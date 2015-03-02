class User < ActiveRecord::Base
<<<<<<< HEAD
	validates :name, presence: true, uniqueness :true 
	has_secure_password
	has_many :items
=======
	has_many :items, inverse_of: :user
>>>>>>> origin/master
end