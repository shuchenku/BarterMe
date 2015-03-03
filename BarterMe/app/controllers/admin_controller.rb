class AdminController < ApplicationController
  def index
    @total_users = User.count
    @total_items = Item.count
  end
end
