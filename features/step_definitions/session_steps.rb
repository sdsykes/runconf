Given /^I am signed in as "([^"]+)"$/ do |name|
  page.driver.post(session_path, {}, {'omniauth.auth' => {'uid' => 1, 'name' => name}})
end

When /^I sign out$/ do
  click_link 'Sign out'
end