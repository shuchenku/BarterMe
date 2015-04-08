class WelcomeController < ApplicationController
  skip_before_action :authorize
  def index
    @top_categories = Item.listing
    @total_items = Item.count
  end
  
  def all_listings
    @all_categories = Item.listing
  end
end
