class Race
  include CouchPotato::Persistence
  
  property :time, type: Time
  property :description
  property :conference_name
  property :conference_url
  property :runkeeper_url
  property :organizer_id
  property :distance, type: Float
  property :runner_ids, default: {} # {user_id => time}
  
  view :by_time, key: :time
  view :by_organizer_id, key: :organizer_id
  
  validates_presence_of :name, :time
  validates_numericality_of :distance
  
  def organizer
    @organizer ||= database.load organizer_id
  end
  
  def runners
    @runners ||= database.view(User.by_id(keys: runner_ids.keys)).sort_by(&:name)
  end
  
  def results
    @results ||= runner_ids.map{|pair|
      [runners.find{|runner| runner.id = pair[0]}, paid[1]]
    }
  end
  
  def over?
    self.time < Time.now
  end
  
  def attend(user)
    runner_ids[user.id] = nil
  end
  
  def drop_out(user)
    runner_ids.delete user.id
  end
end