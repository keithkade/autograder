Then /^I should be shown an alert of failure$/ do
  expect(page).to have_content("Login Failed")
end