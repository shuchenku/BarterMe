 class OfferForm
 	include ActiveModel::Validations
 	include ActiveModel::Conversion
 	extend ActiveModel::Naming

 	attr_accessor :item1_ids, :item2_ids

 	validate :must_ask_for_one
 	validate :must_offer_one
 	validate :items_must_belong_to_one_user

 	def must_ask_for_one
 		unless self.item1_ids.has_value?("1")
 			errors.add(:item1_ids, "Must check at least one item to barter for")
 		end

 		self.items_must_belong_to_one_user

 	end

 	def must_offer_one
 		unless self.item2_ids.has_value?("1")
 			errors.add(:item2_ids, "Must check at least one item to offer")
 		end
 	end

 	def items_must_belong_to_one_user
 		items = Item.find(self.item1_ids.select{|k,v| v == "1"}.keys)

 		unless items.empty?
 			uid = items[0].user_id
 			items.each do |it|
 				if it.user_id != uid
 					errors.add(:item1_ids, "Items must belong to the same user")
 					break
 				end
 			end
 		end
 	end

 	def transform

 		item1_ids = self.item1_ids.select{|k,v| v == "1"}.keys
 		item2_ids = self.item2_ids.select{|k,v| v == "1"}.keys
 		item1 = Item.find(item1_ids)
 		item2 = Item.find(item2_ids)
 		user1_id = item1[0].user_id
 		user2_id = item2[0].user_id
 		item1_names = []
 		item2_names = []
 		item1.each { |i| item1_names << i.name }
 		item2.each { |i| item2_names << i.name }

 		transformed = {:item1_ids => self.item1_ids.select{|k,v| v == "1"}.keys,
 						:item2_ids => self.item2_ids.select{|k,v| v == "1"}.keys,
 						:user1_id => user1_id,
 						:user2_id => user2_id,
 						:item1_names => item1_names.join(", "),
 						:item2_names => item2_names.join(", ")
 						}
 		return transformed
 	end




 	def initialize(attributes = {})
 		attributes.each do |name, value|
 			send("#{name}=", value)
 		end
 	end

 	def persisted?
 		false
 	end

 end