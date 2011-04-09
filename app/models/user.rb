class User
  include CouchPotato::Persistence
  
  property :name
  
  view :by_id, key: :_id
end