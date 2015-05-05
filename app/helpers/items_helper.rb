module ItemsHelper

  def user_looking_for(item)
    return User.looking_for?(item.user)
  end
  
  def matching_items(user, item)
   @possible_trades = Array.new
    user_wants = user_looking_for(item)
    my_items = Item.mine?(user)
    my_items.each do |my_item|
      if user_wants[my_item.category.name] == 0
        @possible_trades.push(my_item)
      end
    end
    return @possible_trades
  end




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
