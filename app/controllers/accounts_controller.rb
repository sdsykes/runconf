class AccountsController < ApplicationController
  before_filter :require_login
  
  def show
    @races = db.view(Race.by_organizer_id(current_user.id))
  end
end