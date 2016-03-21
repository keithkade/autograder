Given(/^I am on the contact page$/) do
  visit('/welcome')
end

When(/^I fill in the contact form$/) do
  fill_in('Message', :with => 'Hello there!')
  find('Submit').click
end

Then(/^I should see a thank you message$/) do
  page.has_content?("Thank you")
end