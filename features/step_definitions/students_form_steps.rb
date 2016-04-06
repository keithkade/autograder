Then /^I have a student named "(.*)"$/ do |name|
    student = student.new
    student.name = name
    student.save
end