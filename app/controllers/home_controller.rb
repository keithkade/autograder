class HomeController < ApplicationController

  def index
    @student = Student.find(session[:user_id])

    dates = (Date.today..Date.today + 7.days)
    active_problems = @student.active_problems
    @problems = []

    #get the problems due this week
    for problem in active_problems
      if dates.include?(problem.due_date.to_date)
        @problems.push(problem)
      end
    end

    all_quizzes = @student.quizzes
    @quizzes = []

    #get the quizzes due this week
    for quiz in all_quizzes
      if dates.include?(quiz.end_time.to_date)
        @quizzes.push(quiz)
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
