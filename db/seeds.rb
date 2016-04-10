#
# Best method to reset your database
# To reset schema (shouldn't be nessecary but do if broken in some way)
# rake db:reset db:migrate
# To reset values 
# rake db:drop db:create db:migrate
#

courses = [{:name => 'CSCE 111'},
           {:name => 'CSCE 121'},
           {:name => 'CSCE 222'},
    ]

students = [{:Name => 'Dillon', :ID => 2222, :UserName => 'dman', :Password => 'password'},
           {:Name => 'Kade', :ID => 2223, :UserName => 'kdog', :Password => 'drowssap'},
    ]
    
problems = [{:title => 'Hello World', :summary => 'Will write hello world', :input_description => 'none', :output_description => 'print Hello World!', :skeleton => 'n\a'},
            {:title => 'Multiple by 10', :summary => 'Will multiple input by 10', :input_description => 'numbers seperated by spaces', :output_description => 'numbers multiplied by 10 seperated by spaces', :skeleton => 'n\a'},
    ]

problem_tests = [{:problemid => 1, :input => '1 2 3', :output => '10 20 30'},
                 {:problemid => 2, :input => '1 2 3', :output => '10 20 30'},
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
