class WelcomeController < ApplicationController
  skip_before_action :authorize
  def index
    @top_categories = Item.listing
    @total_items = Item.count
    if logged_in? && @current_user.looking_for.size >= 1
      best_matches = User.best_match(@current_user)
      @recommendations = best_matches.sample(3)
    end

    if @recommendations.size<3
      @recommendations.concat(Item.all.sample(3-@recommendations.size))
    end
  end
  
  def all_listings
    @all_categories = Item.listing
  end

end
