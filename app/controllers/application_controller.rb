class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  rescue_from CouchPotato::NotFound do
    render file: 'public/404.html', status: :not_found, layout: false
  end
  
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
