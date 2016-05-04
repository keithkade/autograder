Then /^I have a student named "(.*)"$/ do |name|
    student = Student.new
    student.FirstName = name
    student.LastName = "Smith"
    student.password = "test"
    student.save
end

Then /^I have a student with a submission named "(.*)"$/ do |name|
	student = Student.new
    student.FirstName = name
    student.LastName = "Smith"
    student.password = "test"
    student.id = 100
    student.save
    problem = Problem.new
    problem.title = "problem"
    problem.id = 100
   	problem.save
    submission = Submission.new
    submission.student_id = 100
    submission.problem_id = 100
    submission.complete = true
    submission.time_submitted = DateTime.parse("1 May 2016 6:59:59 PM Central Time (US & Canada) ")
    submission.id = 100
    submission.result = '{"status":"success","err":"","results":[{"title":"main case","input":"testingbecauseican","result":"success","output":"testingbecauseican\n","err":""}]}'
    submission.save
end