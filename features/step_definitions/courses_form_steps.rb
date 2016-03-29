Then /^I have a course named "(.*)"$/ do |name|
    course = Course.new
    course.name = name
    course.save
end