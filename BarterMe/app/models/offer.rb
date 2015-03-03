class Offer < ActiveRecord::Base
	 belongs_to :user1, class_name: "User", foreign_key: "user1_id"	 
	 belongs_to :user2, class_name: "User", foreign_key: "user2_id" 
	 validates_presence_of :user1_id
	 validates_associated :user1_id

	 validates_presence_of :item1_id
	 validates_associated :item2_id

	 validate :cant_make_an_offer_to_yourself

	def cant_make_an_offer_to_yourself
		if :user1_id == :user2_id
      		errors.add(:user2_id, "don't barter with your self")
    	end
  	end
 	
	has_many :items
end
