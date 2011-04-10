Given /^I am signed in$/ do
  page.driver.post(session_path, {}, {'omniauth.auth' => {'uid' => '1', 'name' => 'joe'}})
end