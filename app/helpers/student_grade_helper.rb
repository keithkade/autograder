require 'pp'

module StudentGradeHelper

  def getGrade(student_id)
    student = Student.find(student_id)
    problems = student.problems
    success = 0
    all = 0
    for problem in problems
      submissons = Submission.where(:problem_id => problem.id).where(:student_id => student_id)
      submisson_suc = 0
      submisson_all = 0
      for submisson in submissons
        if submisson.time_submitted < problem.due_date
          if submisson_suc < submisson.success_cases
            submisson_suc = submisson.success_cases
          end
          submisson_all = submisson.total_cases
        end
      end
      if submisson_all != 0  #submissions is empty()
        success += submisson_suc
        all += submisson_all
      elsif problem.due_date < DateTime.now.utc  #the due date is passed and they didn't submit, therefore they fail all missed cases
        pp problem.due_date
        pp DateTime.now.utc
        pp ProblemTestCase.where(problemid: problem.id).count
        all += ProblemTestCase.where(problemid: problem.id).count
      else # they havent submitted and the date is not passed so this doesn't affect their grade
        success += submisson_suc
        all += submisson_all
      end
    end
    student.Problems_grade = success.to_s + "/" + all.to_s
    student.save
  end

  
end
