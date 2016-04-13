Given /^I am logged in as Admin$/ do
  visit path_to("the login page")
  fill_in("Username", :with => "admin")
  fill_in("Password", :with => "root")
  click_button("Login")
end

Then /^I should not be logged in as Admin$/ do
  visit path_to("the courses page")
  current_url.should_not == admin_courses_url
end

Then /^I should not be logged in as Student/ do
  visit path_to("the student home page")
  current_url.should_not == '/home'
end

Given /^I am in the student database$/ do
  student = Student.new
  student.UserName = "dman"
  student.Password = "password"
  student.save
end

Given /^I am logged in as Student/ do
  student = Student.new
  student.UserName = "dman"
  student.Password = "password"
  student.save
  visit path_to("the login page")
  fill_in("Username", :with => "dman")
  fill_in("Password", :with => "password")
  click_button("Login")
end
