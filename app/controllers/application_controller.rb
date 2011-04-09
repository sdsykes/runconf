class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  private
  
  def current_user
    @current_user ||= db.load(session[:user_id]) if session[:user_id]
  end
  
  def require_login
    unless current_user
      redirect_to root_path, alert: 'Please sign in'
      false
    end
  end
  
  def db
    @db ||= CouchPotato.database
  end
  
end
