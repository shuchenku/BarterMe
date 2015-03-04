class AdminController < ApplicationController
  before_action :admin_priviledge
  
  def index
    @total_users = User.count
    @total_items = Item.count
  end
end
