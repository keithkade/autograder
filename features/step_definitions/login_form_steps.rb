PAGES = {
    "login page" => "/login",
    "admin index page" => "/admin",
    "home index page" => "/index",
}

Given /^I am on the (.*)$/ do |page|
  visit(PAGES[page])
end

When /^I fill in the login form with valid admin credentials$/ do
  fill_in('Username', :with => 'admin')
  fill_in('Password', :with => 'password')
  find('#login-btn').click
end

When /^I fill in the login form with valid student credentials$/ do
  fill_in('Username', :with => 'home')
  fill_in('Password', :with => 'password')
  find('#login-btn').click
end

When /^I fill in the login form with invalid credentials$/ do
  fill_in('Username', :with => 'bad')
  fill_in('Password', :with => 'bad')
  find('#login-btn').click
end

Then /^I should be on the (.*)$/ do |page|
  assert page.current_path == PAGES[page]
end

Then /^I should be shown an alert of failure$/ do
  expect(page).to have_content("Login Failed")
end