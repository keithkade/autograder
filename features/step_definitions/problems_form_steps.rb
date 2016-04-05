Given /^I already have the problem "(.*)"$/ do |title|
    problem = Problem.new
    problem.title = title
    problem.save
end

Then /^"(.*)" should have field skeleton with value "(.*)"$/ do |title, value|
    problem = Problem.all.find_by(title: title)
    problem.skeleton.should eq(value)
end

Then /^I should not have any problems$/ do
   Problem.count(:all).should eq(0)
end
