Given /^the problem "(.*)" is due in (.*) days$/ do |problem, days|
  problem = Problem.all.find_by(title: problem)
  daysInt = days.to_f
  problem.due_date = (Date.today() + daysInt).to_datetime
  problem.save
end

Given /^the course of problem "(.*)" is archived$/ do |problem|
  problem = Problem.all.find_by(title: problem)
  courses = problem.courses
  courses.each do |course|
    course.is_archived = true
    course.save
  end
end

Given /^the course of problem "(.*)" is not archived$/ do |problem|
  problem = Problem.all.find_by(title: problem)
  courses = problem.courses
  courses.each do |course|
    course.is_archived = false
    course.save
  end
end

Given /^I am in "(.*)" and have the problem "(.*)" assigned to me$/ do |course, problem|
  course = Course.all.find_by(name: course)
  problem = Problem.all.find_by(title: problem)

  student = Student.all.find_by(UserName: 'dman')

  CourseUserRelation.relate!(course.id, student.id)
  CourseProblemRelation.relate!(course.id, problem.id)

  course.save
  problem.save
  student.save
end

Given /^I have a submission for "(.*)" problem$/ do |problem|
  problem = Problem.all.find_by(title: problem)
  student = Student.all.find_by(UserName: 'dman')

  submission = Submission.create!(:code => "test",
                                  :time_submitted => Date.today().to_datetime,
                                  :page_loaded_at => Date.today().to_datetime,
                                  :student_id => student.id,
                                  :problem_id => problem.id,
                                  :result => {}.to_json,
                                  :status => true)
  submission.save
end
