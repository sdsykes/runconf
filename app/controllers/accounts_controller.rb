class AccountsController < ApplicationController
  before_filter :require_login
  
  def show
    @races_organized = db.view(Race.by_organizer_id(current_user.id))
    @races_run = db.view(Race.by_runner_id(current_user.id))
  end
end