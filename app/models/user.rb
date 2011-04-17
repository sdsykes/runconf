class User
  include CouchPotato::Persistence
  
  property :name
  property :email
  
  view :by_id, key: :_id
  view :by_name, key: :name
end