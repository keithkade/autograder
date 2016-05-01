Then /^I have a student named "(.*)"$/ do |name|
    student = Student.new
    student.FirstName = name
    student.LastName = "Smith"
    student.password = "test"
    student.save
end