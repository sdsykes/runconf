Given /^a race "([^"]*)"$/ do |name|
  user = DB.view(User.by_id).first
  DB.save! Race.new(name: name, time: Time.now, distance: '5K', organizer_id: user.id)
end

When /^I add the race "([^"]*)" on the date "([^"]*)"$/ do |name, time|
  visit account_path
  click_link 'Organize a Race'
  fill_in 'Name *', with: name
  fill_in 'Date/Time *', with: time
  select '5K', from: 'Distance'
  click_button 'Add Race'
end

When /^I add the race "([^"]*)" with the runkeeper url "([^"]*)"$/ do |name, runkeeper_url|
  WebMock.stub_request(:get, runkeeper_url).to_return(body: File.read(Rails.root.join('spec', 'fixtures', 'race.html')))
  
  visit account_path
  click_link 'Organize a Race'
  fill_in 'Name *', with: name
  fill_in 'Date/Time *', with: '2011-05-01'
  select '5K', from: 'Distance'
  fill_in 'URL of the race', with: runkeeper_url
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

When /^I change the name of the race "([^"]*)" to "([^"]*)"$/ do |name, new_name|
  race = DB.view(Race.by_name(name)).first
  visit race_path(race)
  click_link 'Edit Race'
  fill_in 'Name', with: new_name
  click_button 'Update Race'
end

Then /^there should be a race "([^"]*)"$/ do |name|
  visit account_path
  page.should have_css('.race', text: name)
end

Then /^there should be no race "([^"]*)"$/ do |name|
  visit account_path
  page.should have_no_css('.race', text: name)
end

Then 'I should see the race map' do
  page.should have_css('#race_map')
end