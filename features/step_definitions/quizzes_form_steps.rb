Then /^I have a quiz named "(.*)"$/ do |title|
  quiz = Quiz.new
  quiz.title = title
  quiz.start_time = (Date.today() - 1).to_datetime
  quiz.save
end

Given /^the quiz "(.*)" is due in (.*) days$/ do |quiz, days|
  quiz = Quiz.all.find_by(title: quiz)
  daysInt = days.to_f
  quiz.end_time = (Date.today() + daysInt).to_datetime
  quiz.save
end

Given /^I am in "(.*)" and have the quiz "(.*)" assigned to me$/ do |course, quiz|
  course = Course.all.find_by(name: course)
  quiz = Quiz.all.find_by(title: quiz)
  student = Student.all.find_by(UserName: 'dman')

  CourseUserRelation.relate!(course.id, student.id)
  quiz.courseid = course.id
  quiz.save
end

Then /^I should not have any quizzes/ do
  Quiz.count(:all).should eq(0)
end