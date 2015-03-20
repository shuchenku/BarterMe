module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    return current_user.admin
  end

  def log_out
    session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end
end
