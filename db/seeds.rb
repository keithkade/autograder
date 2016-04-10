#
# Best method to reset your database

# rake db:reset 
# rake db:drop db:create db:migrate db:seed
#

courses = [{:name => 'CSCE 111'},
           {:name => 'CSCE 121'},
           {:name => 'CSCE 222'},
           {:name => 'CSCE 482'},
           {:name => 'CSCE 431'},
           {:name => 'CSCE 420'},
    ]

students = [{:Name => 'Dillon', :ID => 2222, :UserName => 'dman', :Password => 'password'},
           {:Name => 'Kade', :ID => 2223, :UserName => 'kdog', :Password => 'drowssap'},
           {:Name => 'William', :ID => 2224, :UserName => 'villham', :Password => 'drowpass'},
           {:Name => 'Tim', :ID => 2225, :UserName => 'timayh', :Password => 'wordssap'},
           {:Name => 'Matt', :ID => 2226, :UserName => 'imsaari', :Password => 'ssapdrow'},
    ]
    
problems = [{:title => 'Hello World', :summary => 'Will write hello world', :input_description => 'none', :output_description => 'print Hello World!', :skeleton => 'n\a'},
            {:title => 'Multiple by 10', :summary => 'Will multiply input by 10', :input_description => 'numbers seperated by spaces', :output_description => 'numbers multiplied by 10 seperated by spaces', :skeleton => 'n\a'},
    ]

problem_tests = [{:problemid => 1, :input => '', :output => ''},
                 {:problemid => 2, :input => '1 2 3', :output => '10 20 30'},
                 {:problemid => 2, :input => '40 3 1', :output => '400 30 10'},
    ]

course_student_relations = [{:course => 1, :student => 1},
                            {:course => 1, :student => 2},
                            {:course => 2, :student => 2},
                            {:course => 3, :student => 2},
                            {:course => 5, :student => 4},
                            {:course => 5, :student => 5},
                            {:course => 4, :student => 4},
                            {:course => 4, :student => 5},
                            {:course => 3, :student => 5},
    ]

course_problem_relations = [{:course => 1, :problem => 1},
                            {:course => 2, :problem => 2},
                            {:course => 3, :problem => 2},
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

course_student_relations.each do |course_student_relation|
    CourseUserRelation.relate!(course_student_relation[:course], course_student_relation[:student])
end

course_problem_relations.each do |course_problem_relation|
    CourseProblemRelation.relate!(course_problem_relation[:course], course_problem_relation[:problem])
end