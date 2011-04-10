class Run
  include CouchPotato::Persistence
  
  property :runner_id
  property :time
  property :start_number
end