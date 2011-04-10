Given /^a race "([^"]*)"$/ do |name|
  user = DB.view(User.by_id).first
  DB.save! Race.new(name: name, time: Time.now, distance: '5K', organizer_id: user.id)
end

When /^I add the race "([^"]*)" on the date "([^"]*)"$/ do |name, time|
  visit account_path
  click_link 'Organize a Race'
  fill_in 'Name *', with: name
  fill_in 'Date/Time *', with: time
  fill_in 'Distance *', with: '5K'
  click_button 'Add Race'
end

