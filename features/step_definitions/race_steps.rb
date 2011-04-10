When /^I add the race "([^"]*)" on the date "([^"]*)"$/ do |name, time|
  visit account_path
  click_link 'Organize a Race'
  fill_in 'Name *', with: name
  fill_in 'Date/Time *', with: time
  fill_in 'Distance *', with: '5K'
  click_button 'Add Race'
end