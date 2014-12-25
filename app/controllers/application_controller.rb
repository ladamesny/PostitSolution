class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #makes controller methods available in the view templates
  helper_method :current_user, :logged_in?

  def current_user
    #memoization method returns user object only if @current_user is nil. "if" statement makes this return "nil" instead of throwing an exception
    #if User.find can't find a user.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    #turns result into a boolean value.
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end  
  end

end
