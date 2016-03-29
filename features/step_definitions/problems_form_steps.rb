Given /^I already have the problem "(.*)"$/ do |title|
    problem = Problem.new
    problem.title = title
    problem.save
end

Then /^"(.*)" should have field skeleton with value "(.*)"$/ do |title, value|
    problem = Problem.all.find_by(title: title)
    assert_equal value, problem.skeleton
end

Then /^I should not have any problems$/ do
   assert_equal Problem.count(:all), 0
end