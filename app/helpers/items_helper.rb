module ItemsHelper

  def user_looking_for(item)
    return User.looking_for?(item.user)
  end
  
  def matching_items(user, item)
   @possible_trades = Array.new
    user_wants = user_looking_for(item)
    my_items = Item.mine?(user)
    my_items.each do |my_item|
      @possible_trades.push(my_item) if user_wants[my_item] == 0
    end
    return @possible_trades
  end




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
