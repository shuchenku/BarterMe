class User < ActiveRecord::Base
	has_many :items, inverse_of: :user
end