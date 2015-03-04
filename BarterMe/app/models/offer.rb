class Offer < ActiveRecord::Base
	 belongs_to :user1, class_name: "User", foreign_key: "user1_id"	 
	 belongs_to :user2, class_name: "User", foreign_key: "user2_id" 
	 validates_presence_of :user1
	 validates_associated :user1

	 validates_presence_of :user2
	 validates_associated :user2

	 # items
	 belongs_to :item1, class_name: "Item", foreign_key: "item1_id"	 
	 belongs_to :item2, class_name: "Item", foreign_key: "item2_id" 
	 validates_presence_of :item1
	 validates_associated :item1

	 validates_presence_of :item2
	 validates_associated :item2
end
