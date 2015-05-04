module ItemsHelper
	def item_available?(id)
		o1 = Offer.find_by item1_id:id
		o2 = Offer.find_by item2_id:id

		if o1.nil? && o2.nil? 
			return true
		elsif o1.nil?
			return !o2.accepted
		else 
			return !o1.accepted
		end
				
	end


	def belongs_to_current_user(id)
		user_id = Item.find(id).user_id
		return user_id == @current_user.id
	end

end
