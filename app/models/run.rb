class Run
  include CouchPotato::Persistence
  attr_accessor :runner
  
  property :runner_id
  property :time
  property :start_number
  
  validates_format_of :time, :with => /^\d+:\d+$/, message: 'must match mm:ss'
end