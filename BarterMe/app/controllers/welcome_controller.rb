class WelcomeController < ApplicationController
  skip_before_action :authorize
  def index
    @total_items = Item.count
  end
end
