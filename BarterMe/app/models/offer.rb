class Offer < ActiveRecord::Base
	 belongs_to :user1, class_name: "User", foreign_key: "user1_id"	 
	 belongs_to :user2, class_name: "User", foreign_key: "user2_id" 
	 validates_presence_of :user1_id
	 validates_associated :user1

	 validates_presence_of :user2_id
	 validates_associated :user2

	 has_many :items
end
