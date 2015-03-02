class SessionsController < ApplicationController
  
  skip_before_action :authorized

  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user and user.authenticate(params[:password])
  		session[:email] = user.email
  		redirect_to admin_url
  	else
  		redirect_to login_url, alert: "Invalid /email/password combination"
  	end
  end

  def destroy
    session[:user_email] = nil
    redirect_to item_url, notice: "Logged out"
  end
end
