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
  
  view :by_name, key: :name
  view :by_time, key: :time
  view :by_organizer_id, key: :organizer_id
  view :by_runner_id, type: :custom, include_docs: true,
    map: <<-JS
      function(doc) {
        if(doc.ruby_class == 'Race') {
          for(var i in doc.runs) {
            emit(doc.runs[i].runner_id, 1);
          }
        }
      }
    JS
  
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
    is_dirty
  end
  
  def drop_out(user)
    runs.reject!{|run| run.runner_id == user.id}
    is_dirty
  end
end