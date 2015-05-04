class WelcomeController < ApplicationController
  skip_before_action :authorize
  def index
    @top_categories = Item.listing
    @total_items = Item.count
    recommended_barters = Offer.where(accepted: true)
    if recommended_barters != nil
      @recommended_barter = barter_spotlight(recommended_barters.sample)
    else
      @recommended_barter = recommended_barters.sample
    end
    if logged_in? && @current_user.looking_for.size >= 1
      best_matches = User.best_match(@current_user)
      @recommendations = best_matches.sample(3)
      if @recommendations.size<3
        @recommendations.concat(Item.all.sample(3-@recommendations.size))
      end
    else
      @recommendations = Item.all.sample(3)
    end
  end
 
  def all_listings
    @all_categories = Item.listing
  end
  
  def barter_spotlight(recommended_barter)
    barter_data = Array.new
    barter_data[0] = recommended_barter.user1.user_name
    barter_data[1] = recommended_barter.user2.user_name
    barter_data[2] = Item.find(recommended_barter.item1_id).name
    barter_data[3] = Item.find(recommended_barter.item2_id).name
    barter_data[4] = recommended_barter.user1.id
    barter_data[5] = recommended_barter.user2.id
    return barter_data
  end

end
