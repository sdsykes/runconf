class User
  include CouchPotato::Persistence
  
  property :name
  
  view :by_id, key: :_id
  view :by_name, key: :name
end