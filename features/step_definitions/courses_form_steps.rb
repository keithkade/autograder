Given /^I have a course named "(.*)" on "(.*)", "(.*)"$/ do |name, semester, year|
    course = Course.new
    course.name = name
    course.semester = semester.to_s
    course.year = year.to_i
    course.is_archived = false
    course.save
end

Then /^put the page in console$/ do
    print page.html
    print "\n\n"
end