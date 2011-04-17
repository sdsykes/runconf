class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if auth
      user = find_user(auth) || create_user(auth)
      session[:user_id] = user.id
      redirect_to account_path, :notice => "Welcome, #{user.name}!"
    else
      redirect_to root_path, :alert => "Couldn't log you in, please retry"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "Bye bye!"
  end
  
  private
  
  def find_user(auth)
    db.load auth["uid"].to_s
  end
  
  def create_user(auth)
    user = User.new id: auth['uid'].to_s, name: auth['name']
    db.save user
    user
  end
  
end