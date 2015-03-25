class Offer < ActiveRecord::Base
	 
	 belongs_to :user1, class_name: "User", foreign_key: "user1_id"	 
	 belongs_to :user2, class_name: "User", foreign_key: "user2_id" 
	 validates_presence_of :user1_id
	 validates_associated :user1

	 validates_presence_of :user2_id
	 validates_associated :user2

	 # items
	 # belongs_to :item1, class_name: "Item", foreign_key: "item1_id"	 
	 # belongs_to :item2, class_name: "Item", foreign_key: "item2_id" 
	 # validates_presence_of :item1_id
	 # validates_associated :item1

	 # validates_presence_of :item2_id
	 # validates_associated :item2
	 validate :must_have_two_items

	 def must_have_two_items
	 	if self[:item1_id].nil? || self[:item2_id].nil? 
	 		errors.add(:base, "Neither item can be nil when make an offer")
	 	end
	 end

	 # validate :item_id_must_be_valid
	 # def item_id_must_be_valid
	 # 	 if !(self[:item1_id].nil? || self[:item2_id].nil? )
	 # 	 	if !(check_item_id(self[:item1_id]) && check_item_id(self[:item2_id]))
	 # 	 		errors.add(:base, "Both items in an offer should have valid id")
	 # 	 	end
	 # 	 end
	 # end

	 # def check_item_id(idString) 
	 # 	split = idString.split(',')
	 # 	split.each do |id|
	 # 		if Item.where(:id => id.strip.to_i).blank?
	 # 			return false
	 # 		end
	 # 	end
	 # 	return true
	 # end


	 validate :cant_make_an_offer_to_yourself

	def cant_make_an_offer_to_yourself
		if self[:user1_id] == self[:user2_id]
      		errors.add(:user2_id, "don't barter with yourself")
    	end
  	end
 	
	has_many :items
end
