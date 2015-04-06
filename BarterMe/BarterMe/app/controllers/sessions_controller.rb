class SessionsController < ApplicationController
  require 'sessions_helper'
  skip_before_action :authorize

  def new
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user and user.authenticate(params[:password])
          log_in user
          if admin?
            redirect_to admin_url
          else
            redirect_to items_url
          end
  	else
          redirect_to login_url, alert: "Invalid /email/password combination"
  	end
  end
  
  def destroy
    log_out
  end
end
