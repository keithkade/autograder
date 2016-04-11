Given /^I already have the problem "(.*)"$/ do |title|
    problem = Problem.new
    problem.title = title
    problem.save
end

Given /^the problem "(.*)" has a "(.*)" test case$/ do |problem, testcase|
    problem = Problem.all.find_by(title: problem)
    testCase = ProblemTestCase.new
    testCase.problemid = problem.id
    testCase.input = 'test'
    testCase.output = 'test'
    testCase.save
end

Given /^I fill in the ace editor with "(.*)"$/ do |code|
    page.execute_script("editor.setValue('" + code + "')")
end

Then /^"(.*)" should have field skeleton with value "(.*)"$/ do |title, value|
    problem = Problem.all.find_by(title: title)
    problem.skeleton.should eq(value)
end

Then /^I should not have any problems$/ do
   Problem.count(:all).should eq(0)
end
