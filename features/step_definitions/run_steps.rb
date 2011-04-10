Given /^I'm running the race "([^"]+)"$/ do |name|
  user = DB.view(User.by_id).first
  race = DB.view(Race.by_name(name)).first
  race.run user
  DB.save! race
end

Given /^"([^"]*)" is running the race "([^"]*)"$/ do |user_name, race_name|
  user = DB.view(User.by_name(user_name)).first
  race = DB.view(Race.by_name(race_name)).first
  race.run user
  DB.save! race
end

When /^I run the race "([^"]*)"$/ do |name|
  visit path_to("the race \"#{name}\"")
  click_link "Run this race"
end

  
When /^I drop out of the race "([^"]+)"$/ do |name|
  visit path_to("the race \"#{name}\"")
  click_link "Drop out of this race"
end

Then /^I should see that I'm running at "([^"]*)"$/ do |name|
  page.should have_css('.races_run', text: name)
end

Then /^I should not see that I'm running at "([^"]*)"$/ do |name|
  page.should have_no_css('.races_run', text: name)
end

Then /^I should see that "([^"]*)" is running$/ do |name|
  page.should have_css('.runners', text: name)
end

Then /^I should not see that "([^"]*)" is running$/ do |name|
  page.should have_no_css('.runners', text: name)
end

Then /^I should see that "([^"]*)" finished on position "([^"]*)" after "([^"]*)"$/ do |name, position, time|
  page.should have_xpath("//tr[child::td[contains(., '#{name}')]][child::td[contains(., '#{position}')]][child::td[contains(., '#{time}')]]")
end

Then /^I should see that "([^"]*)" finished before "([^"]*)"$/ do |name1, name2|
  page.body.should =~ /#{name1}.+#{name2}/m
end