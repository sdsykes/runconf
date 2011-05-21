Before do
  DB ||= CouchPotato.database
  CouchPotato.couchrest_database.delete! rescue nil
  CouchPotato.couchrest_database.create!
end
