class AttendancesController < ApplicationController
  before_filter :require_login
  
  def create
    race = db.load params[:race_id]
    race.attend current_user
    db.save race
    redirect_to race
  end
  
  def destroy
    race = db.load params[:race_id]
    race.drop_out current_user
    db.save race
    redirect_to race
  end
end