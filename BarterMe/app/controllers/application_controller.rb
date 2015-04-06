class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  # include CurrentCart
  before_action :set_cart 

  # protect_from_forgery with: :exception
  before_action :authorize 
  


  protected

  def set_cart 
    if logged_in?
      user = User.find(session[:user_id])
      if user.cart_id.nil?
         @cart = Cart.create
        user[:cart_id] = @cart.id
        user.save
      else
        @cart = Cart.find(user.cart_id)
      end
      session[:cart_id] = @cart.id
    end
  end

  def authorize
    unless logged_in?
      redirect_to login_url, notice: "Please log in"
    end
  end
  
  def admin_priviledge
    unless admin?
      redirect_to login_url, notice:  "Must be admin to view"
    end
  end
end
