Then /^I have a problem named "(.*)"$/ do |name|
    problem = Problem.new
    problem.title = name
    problem.due_date =  DateTime.parse('1 May 2016 11:59:59 PM')
    problem.save
end

Given /^I already have the python io problem and am on that page$/ do
    problem = Problem.new
    problem.title = 'io practice python'
    problem.language = 'python'
    problem.due_date =  DateTime.parse('1 May 2016 11:59:59 PM')
    problem.save

    problem = Problem.all.find_by(title: 'io practice python')
    testCase = ProblemTestCase.new
    testCase.problemid = problem.id
    testCase.input = 'testingbecauseican'
    testCase.output = 'testingbecauseican'
    testCase.save

    visit "/problems/#{problem.id}"
end

Given /^the problem "(.*)" has a "(.*)" test case$/ do |problem, testcase|
    problem = Problem.all.find_by(title: problem)
    testCase = ProblemTestCase.new
    testCase.problemid = problem.id
    testCase.input = 'test'
    testCase.output = 'test'
    testCase.save
end

Given /^I fill in the ace editor with an ok python solution$/ do
    page.execute_script("editor.setValue(\"x=1\")")
end

Given /^I fill in the ace editor with a bad python solution$/ do
    page.execute_script("editor.setValue(\"ayyyy lmao\")")
end

Then /^"(.*)" should have field skeleton with value "(.*)"$/ do |title, value|
    problem = Problem.all.find_by(title: title)
    problem.skeleton.should eq(value)
end

Then /^I should not have any problems$/ do
   Problem.count(:all).should eq(0)
end
