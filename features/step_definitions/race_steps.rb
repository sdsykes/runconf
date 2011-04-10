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

When /^I enter the following race results for "([^"]+)"$/ do |name, table|
  race = DB.view(Race.by_name(name)).first
  visit race_path(race)
  click_link 'Results'
  table.rows_hash.each do |name, time|
    fill_in name, with: time
  end
  click_button 'Save Results'
end
