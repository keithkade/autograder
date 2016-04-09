Then /^I have a student named "(.*)"$/ do |name|
    student = Student.new
    student.Name = name
    student.save
end