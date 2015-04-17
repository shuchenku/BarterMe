class Offer < ActiveRecord::Base

	has_many :items
	has_many :comments

	belongs_to :user1, class_name: "User", foreign_key: "user1_id"	 
	belongs_to :user2, class_name: "User", foreign_key: "user2_id" 

	validates_presence_of :user1_id
	validates_associated :user1

	validates_presence_of :user2_id
	validates_associated :user2

	private

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


	def self.proposed?(user)
    	offers2 = Offer.where(:user2_id => user.id)
  	end

  	def self.received?(user)
  		offers1 = Offer.where(:user1_id => user.id)
  	end

  	def  self.mine?(user)
  		return @offer.user2_id == user.id
  	end

  	def self.pending?
  		@offers = Offer.where(:pending => true)
  	end


end
