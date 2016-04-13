#
# Best method to reset your database

# rake db:reset 
# rake db:drop db:create db:migrate db:seed
#
result = '{
  status: "success"
  err: nil
  results : [
    {
      title: "test case #0",
      result: "success",
      err: nil,
      input: "testingbecauseican"
    },
  ]
}'


courses = [{:name => 'CSCE 111'},
           {:name => 'CSCE 121'},
           {:name => 'CSCE 222'},
           {:name => 'CSCE 482'},
           {:name => 'CSCE 431'},
           {:name => 'CSCE 420'},
           ]

students = [{:FirstName => 'Dillon', :LastName => 'Dishman', :ID => 2222, :UserName => 'dman', :Password => 'password'},
           {:FirstName => 'Kade', :LastName => 'Keith', :ID => 2223, :UserName => 'kdog', :Password => 'drowssap'},
           {:FirstName => 'William', :LastName => 'Bracho Blok', :ID => 2224, :UserName => 'villham', :Password => 'drowpass'},
           {:FirstName => 'Timothy', :LastName => 'Foster', :ID => 2225, :UserName => 'timayh', :Password => 'wordssap'},
           {:FirstName => 'Matt', :LastName => 'Saari', :ID => 2226, :UserName => 'imsaari', :Password => 'ssapdrow'},
           {:FirstName => 'Jeff Dean', :LastName => '', :ID => 0, :UserName => 'the one', :Password => ''},
           ]
    
problems = [{:title => 'Hello World', :due_date => DateTime.parse('1 May 2016 11:59:59 PM'), :summary => 'Will write hello world', :input_description => 'none', :output_description => 'print Hello World!', :skeleton => 'n\a', :language => 'java'},
            {:title => 'IO Practice Java', :due_date => DateTime.parse('2 May 2016 11:59:59 PM'), :summary => 'Read in input from input.txt and output it to output.txt', :input_description => 'string', :output_description => 'should read same as input.txt', :skeleton => 'n/a', :language => 'java'},
            {:title => 'Multiple by 10', :due_date => DateTime.parse('3 May 2016 11:59:59 PM'), :summary => 'Will multiply input by 10', :input_description => 'numbers seperated by spaces', :output_description => 'numbers multiplied by 10 seperated by spaces', :skeleton => 'n\a', :language => 'java'},
            {:title => 'IO Practice Python', :due_date => DateTime.parse('4 May 2016 11:59:59 PM'), :summary => 'Read in input from input.txt and output it to output.txt', :input_description => 'string', :output_description => 'should read same as input.txt', :skeleton => 'n/a', :language => 'python'},
            ]

problem_tests = [{:problemid => 1, :input => '', :output => ''},
                 {:problemid => 2, :input => 'testingbecauseican', :output => 'testingbecauseican'},
                 {:problemid => 3, :input => '1 2 3', :output => '10 20 30'},
                 {:problemid => 3, :input => '40 3 1', :output => '400 30 10'},
                 {:problemid => 4, :input => 'testingbecauseican', :output => 'testingbecauseican'},
                 ]

course_student_relations = [{:course => 1, :student => 1}, {:course => 2, :student => 2}, {:course => 3, :student => 2}, {:course => 4, :student => 4}, {:course => 5, :student => 4},  {:course => 6, :student => 6},
                            {:course => 1, :student => 2}, {:course => 2, :student => 5}, {:course => 3, :student => 5}, {:course => 4, :student => 5}, {:course => 5, :student => 5},
                            {:course => 1, :student => 6}, {:course => 2, :student => 6}, {:course => 3, :student => 6}, {:course => 4, :student => 6}, {:course => 5, :student => 6},
                            ]

course_problem_relations = [{:course => 1, :problem => 1}, {:course => 2, :problem => 2}, {:course => 3, :problem => 2}, {:course => 4, :problem => 2}, {:course => 5, :problem => 2}, {:course => 6, :problem => 2},
                            {:course => 1, :problem => 2}, {:course => 2, :problem => 3}, {:course => 3, :problem => 3}, {:course => 4, :problem => 4}, {:course => 5, :problem => 4}, {:course => 6, :problem => 4},
                            {:course => 1, :problem => 4}, {:course => 2, :problem => 4}, {:course => 3, :problem => 4},
                            ]

submission = [{:student_id => 6, :problem_id => 2, :code => 'I am Jeff Dean', :page_loaded_at => DateTime.parse('1 January 1970 12:00:00 AM'), :time_submitted => DateTime.parse('1 January 1970 12:00:01 AM'), :result => result, :status => true},
              ]

courses.each do |course|
    Course.create!(course)
end

students.each do |student|
    Student.create!(student)
end

problems.each do |problem|
    Problem.create!(problem)
end

problem_tests.each do |problem_test|
    ProblemTestCase.create!(problem_test)
end

submissions.each do |submission|
    Submission.create!(submission)
end

course_student_relations.each do |course_student_relation|
    CourseUserRelation.relate!(course_student_relation[:course], course_student_relation[:student])
end

course_problem_relations.each do |course_problem_relation|
    CourseProblemRelation.relate!(course_problem_relation[:course], course_problem_relation[:problem])
end