class Race
  include CouchPotato::Persistence
  
  property :name
  property :time, type: Time
  property :description
  property :conference_name
  property :conference_url
  property :runkeeper_url
  property :organizer_id
  property :distance, type: Float
  property :runs, default: []
  
  view :by_time, key: :time
  view :by_organizer_id, key: :organizer_id
  
  validates_presence_of :name, :time
  validates_numericality_of :distance
  
  def organizer
    @organizer ||= database.load organizer_id
  end
  
  def runners
    @runners ||= database.view(User.by_id(keys: runs.map(&:runner_id))).sort_by(&:name)
  end
  
  def over?
    self.time < Time.now
  end
  
  def run(user)
    runs << Run.new(runner_id: user.id)
  end
  
  def drop_out(user)
    runs.reject!{|run| run.runner_id == user.id}
  end
end