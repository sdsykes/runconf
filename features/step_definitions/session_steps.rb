Given /^I am signed in as "([^"]+)"$/ do |name|
  page.driver.post(session_path, {}, {'omniauth.auth' => {'uid' => 1, 'user_info' => {'name' => name, 'email' => "#{name}@example.com"}}})
end

When /^I sign out$/ do
  click_link 'Sign out'
end