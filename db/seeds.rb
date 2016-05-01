#
# Best method to reset your database

# rake db:reset 
# rake db:drop db:create db:migrate db:seed
#
result = {}
result[:status] = "success"
result[:err] = nil
results = []
results_one = {}
results_one[:title] = "test case #0"
results_one[:result] = "success"
results_one[:err] = "nil"
results_one[:input] = "testingbecauseican"
results.push(results_one)
result[:results] = results

java_skeleton = 'import java.io.*;
import java.util.*;

public class useCode {

    public static ArrayList<Integer> yourCode(ArrayList<Integer> input) {
        //your code here
        return input;
    }		
  
    public static void main(String args[]) throws IOException{
        FileInputStream is = null;
        FileOutputStream os = null;
        try {
            Scanner in = new Scanner(System.in);
            ArrayList<Integer> input = new ArrayList<Integer>();
            while(in.hasNextInt()){
                input.add(new Integer(in.nextInt()));
            }
            ArrayList<Integer> output = yourCode(input);
            for(Integer i: output){
                System.out.print(i + " ");
            }
        } 
        finally {
            if (is != null) {is.close();}
            if (os != null) {os.close();}
        }
    
    }
}'


courses = [{:name => 'CSCE 111', :semester => 'Spring', :year => 2016, :is_archived => false},
           {:name => 'CSCE 121', :semester => 'Fall', :year => 2016, :is_archived => false},
           {:name => 'CSCE 222', :semester => 'Spring', :year => 2017, :is_archived => false},
           {:name => 'CSCE 482', :semester => 'Spring', :year => 2017, :is_archived => false},
           {:name => 'CSCE 431', :semester => 'Summer', :year => 2018, :is_archived => false},
           {:name => 'CSCE 420', :semester => 'Winter', :year => 2018, :is_archived => false},
           ]

students = [{:FirstName => 'Dillon', :LastName => 'Dishman', :ID => 2222, :UserName => 'dman', :Password => 'password'},
           {:FirstName => 'Kade', :LastName => 'Keith', :ID => 2223, :UserName => 'kdog', :Password => 'drowssap'},
           {:FirstName => 'William', :LastName => 'Bracho Blok', :ID => 2224, :UserName => 'villham', :Password => 'drowpass'},
           {:FirstName => 'Timothy', :LastName => 'Foster', :ID => 2225, :UserName => 'timayh', :Password => 'wordssap'},
           {:FirstName => 'Matt', :LastName => 'Saari', :ID => 2226, :UserName => 'imsaari', :Password => 'password'},
           {:FirstName => 'Jeff Dean', :LastName => '', :ID => 0, :UserName => 'the one', :Password => ''},
           ]
    
problems = [{:title => 'Hello World', :due_date => DateTime.parse('1 May 2016 11:59:59 PM'), :summary => 'Will write hello world', :input_description => 'none', :output_description => 'print Hello World!', :skeleton => 'n\a', :language => 'java'},
            {:title => 'IO Practice Java', :due_date => DateTime.parse('2 May 2016 11:59:59 PM'), :summary => 'Read in input from input.txt and output it to output.txt', :input_description => 'string', :output_description => 'should read same as input.txt', :skeleton => 'n/a', :language => 'java'},
            {:title => 'IO Practice Python', :due_date => DateTime.parse('4 May 2016 11:59:59 PM'), :summary => 'Read in input from input.txt and output it to output.txt', :input_description => 'string', :output_description => 'should read same as input.txt', :skeleton => 'n/a', :language => 'python'},
            {:title => 'Sort a List', :due_date => DateTime.parse('25 April 11:59:59 PM'), :summary => 'You will need to write a program that can take in a generic size list and sort it using any the of sorting algorithms we learned in class. Write the sorting method yourself, do not use library sorting methods.', :input_description => 'Unsorted ArrayList of Numbers', :output_description => 'Sorted Array List of Integers', :skeleton => java_skeleton, :language => 'java'},
            {:title => 'OLD', :due_date => DateTime.parse('1 May 2016 11:59:59 PM'), :summary => 'W', :input_description => 'none', :output_description => 'print!', :skeleton => 'n\a', :language => 'java'},
            ]

problem_tests = [{:problemid => 1, :title => 'main case', :input => '', :output => ''},
                 {:problemid => 2, :title => 'main case', :input => 'testingbecauseican', :output => 'testingbecauseican'},
                 {:problemid => 3, :title => 'main case', :input => 'testingbecauseican', :output => 'testingbecauseican'},
                 {:problemid => 4, :title => 'Empty List Sorting', :input => '', :output => ''},
                 {:problemid => 4, :title => 'Sorted List Sorting', :input => '1 2 3 ', :output => '1 2 3 '},
                 {:problemid => 4, :title => 'Unsorted List Sorting', :input => '1 3 2 9 2 8 5 6 3', :output => '1 2 2 3 3 5 6 8 9 '},
                 ]

course_student_relations = [{:course => 1, :student => 1}, {:course => 2, :student => 2}, {:course => 3, :student => 2}, {:course => 4, :student => 3}, {:course => 5, :student => 3},  {:course => 6, :student => 6}, {:course => 7, :student => 6},
                            {:course => 1, :student => 2}, {:course => 2, :student => 4}, {:course => 3, :student => 4}, {:course => 4, :student => 4}, {:course => 5, :student => 4},
                            {:course => 1, :student => 5}, {:course => 2, :student => 6}, {:course => 3, :student => 6}, {:course => 4, :student => 6}, {:course => 5, :student => 6},
                            {:course => 1, :student => 6},
                            ]

course_problem_relations = [{:course => 1, :problem => 1}, {:course => 2, :problem => 2}, {:course => 3, :problem => 2}, {:course => 4, :problem => 2}, {:course => 5, :problem => 2}, {:course => 6, :problem => 2}, {:course => 7, :problem => 5},
                            {:course => 1, :problem => 2}, {:course => 2, :problem => 3}, {:course => 3, :problem => 3}, {:course => 4, :problem => 4}, {:course => 5, :problem => 4}, {:course => 6, :problem => 4},
                            {:course => 1, :problem => 3}, {:course => 2, :problem => 4}, {:course => 3, :problem => 4},
                            {:course => 1, :problem => 4},
                            ]

submissions = [{:student_id => 6, :problem_id => 2, :code => 'I am Jeff Dean', :page_loaded_at => DateTime.parse('1 January 1970 12:00:00 AM'), :time_submitted => DateTime.parse('1 January 1970 12:00:01 AM'), :result => result.to_json, :status => true},
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