module ItemsHelper
	def item_available?(id)
		
		q = Item.find(id).quantity

		if q > 0
			return true
		end

		return false
				
	end

	def belongs_to_current_user(id)
		user_id = Item.find(id).user_id
		return user_id == @current_user.id
	end

end
