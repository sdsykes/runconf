Given /^I'm running the race "([^"]+)"$/ do |name|
  user = DB.view(User.by_id).first
  race = DB.view(Race.by_name(name)).first
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


Then /^I should not see that "([^"]*)" is running$/ do |name|
  page.should have_no_css('.runners', text: name)
end