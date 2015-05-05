class WelcomeController < ApplicationController
  skip_before_action :authorize
  def index
    get_barters
    get_recommendations
  end
 
  def all_listings
    @all_categories = Item.listing
  end

  def get_barters
    @top_categories = Item.listing
    @total_items = Item.count
    recommended_barters = Offer.where(accepted: true)
    if !recommended_barters.nil? && !recommended_barters.empty?
      @recommended_barter = barter_spotlight(recommended_barters.sample)
    end
  end

  def get_recommendations
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


  
  def barter_spotlight(recommended_barter)
    barter_data = Array.new
    barter_data[0] = User.find(recommended_barter.user1_id)
    barter_data[1] = User.find(recommended_barter.user2_id)
    barter_data[2] = Item.find_all_by_id(recommended_barter.item1_id.split(",").map(&:to_i))
    barter_data[3] = Item.find_all_by_id(recommended_barter.item2_id.split(",").map(&:to_i))
    return barter_data
  end

end
