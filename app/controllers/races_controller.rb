class RacesController < ApplicationController
  before_filter :require_login, except: [:show, :index]
  
  def index
    @upcoming_races = db.view Race.by_time(startkey: Time.now.as_json)
  end
  
  def new
    @race = Race.new
  end
  
  def create
    @race = Race.new params[:race]
    @race.organizer_id = current_user.id
    if db.save @race
      redirect_to @race
    else
      render 'new'
    end
  end
  
  def show
    @race = db.load params[:id]
    if params[:show] == 'results'
      @results = @race.results
      render 'results' 
    else
      @runners = @race.runners
    end
    
  end
end