class UsersController < ApplicationController
  def show
    @user = db.load! params[:id]
  end
end