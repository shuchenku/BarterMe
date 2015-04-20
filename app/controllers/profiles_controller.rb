class ProfilesController < ApplicationController

  def profile
    if params[:id].present?
      @user = User.find(params[:id])
    else   
      @user = User.find_by(id: session[:user_id])
    end
    user = @user
    @items = Item.mine? user
  end

  def other_users
    @users = User.all
  end
    
end
