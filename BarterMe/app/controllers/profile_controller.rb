class ProfileController < ApplicationController

  def index 
    @user = User.find_by(id: session[:user_id])
    user = @user
    @items = Item.mine? user
  end

end
