Given /^a user "([^"]*)"$/ do |name|
  DB.save! User.new(name: name)
end