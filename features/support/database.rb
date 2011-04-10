DB = CouchPotato.database

Before do
  CouchPotato.couchrest_database.delete! rescue nil
  CouchPotato.couchrest_database.create!
end
