class Offer < ActiveRecord::Base

	has_many :items

	belongs_to :user1, class_name: "User", foreign_key: "user1_id"	 
	belongs_to :user2, class_name: "User", foreign_key: "user2_id" 

	validates_presence_of :user1_id
	validates_associated :user1

	validates_presence_of :user2_id
	validates_associated :user2

	private

	 # items
	 # belongs_to :item1, class_name: "Item", foreign_key: "item1_id"	 
	 # belongs_to :item2, class_name: "Item", foreign_key: "item2_id" 
	 validates_presence_of :item1_id
	 # validates_associated :item1

	 validates_presence_of :item2_id
	 # validates_associated :item2
	 validate :must_have_two_items

	 # validate :verify_item1
	 # validate :verify_item2

	 def must_have_two_items
	 	 if self[:item1_id].nil? || self[:item2_id] == 'none selected'
	 	# if self[:item1_id].nil? || self[:item2_id].nil?
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

	 def self.mine?(user)
	 	@offers = Offer.where('user1_id = ? OR user2_id = ?', user.id, user.id)
	 end

	 def verify_item2
	 	check_availabity(self[:item2_id])
	 end

	 def verify_item1
	 	check_availabity(self[:item1_id])
	 end

	 def check_availabity(items_list)
	 	ids = items_list.split(",").map(&:to_i)
	 	ids.each do |id|
	 		unless Item.exists?(id)
	 			errors.add(items_list,"offer contains unavailable item(s)")
	 		end 
	 	end
	 end

end
