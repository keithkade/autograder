class HomeController < ApplicationController

  def index
    @student = Student.find(session[:user_id])

    courses = @student.courses
    all_problems = []
    @problems = []

    for course in courses
      # Prevents duplicates of problems from appearing.
      all_problems.concat(Array(course.problems).keep_if { |prob| not all_problems.map { |prob2| prob2.id }.include?(prob.id) })
    end

    #get the problems due this week
    dates = (Date.today..Date.today + 7.days)
    for problem in all_problems
      if dates.include?(problem.due_date.to_date)
        @problems.push(problem)
      end
    end

    @submissions = Submission.order('time_submitted DESC').where(:student_id => @student.id)
    @problemNames = Hash.new

    @testCaseResults = []

    @submissions.each do |submission|
      problem = Problem.find_by_id(submission.problem_id)
      if not problem.nil?
        @problemNames[submission.problem_id] = problem.title
      end

      if submission.total_cases > 0
        @testCaseResults.push(submission.success_cases.to_s + '/' + submission.total_cases.to_s)
      else
        @testCaseResults.push('Compile Error')
      end
    end
  end
end
