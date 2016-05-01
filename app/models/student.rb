class Student < ActiveRecord::Base
    require 'pp'

    has_secure_password

    def courses
        tuples = CourseUserRelation.where(:user => id)
        Course.where(:id => tuples.map(&:course))
    end
    
    def submissions
    	Submission.where(:student_id => self.id)
    end

    def problems
        courses = self.courses
        all_problems = []

        for course in courses
            # Prevents duplicates of problems from appearing.
            all_problems.concat(Array(course.problems).keep_if { |prob| not all_problems.map { |prob2| prob2.id }.include?(prob.id) })
        end
        all_problems
    end

		def active_problems
			courses = self.courses
			all_problems = []

			for course in courses
				if course.is_archived
					next
				end

				# Prevents duplicates of problems from appearing.
				all_problems.concat(Array(course.problems).keep_if { |prob| not all_problems.map { |prob2| prob2.id }.include?(prob.id) })
			end

			all_problems
		end

    def Name
        self.FirstName + " " + self.LastName
    end


	def problems_grade
	    student = Student.find(self.id)
	    problems = student.problems
	    success = 0
	    all = 0
	    for problem in problems
	      submissons = Submission.where(:problem_id => problem.id).where(:student_id => self.id)
	      submisson_suc = 0
	      submisson_all = 0
	      for submisson in submissons
	        if submisson.total_cases > 0
	          if submisson.time_submitted < problem.due_date
	            if submisson_suc < submisson.success_cases
	              submisson_suc = submisson.success_cases
	            end
	            submisson_all = submisson.total_cases
	          end
	        else
	          submisson_all = ProblemTestCase.where(problemid: problem.id).count
	        end
	      end
	      if submisson_all != 0  #submissions is empty()
	        success += submisson_suc
	        all += submisson_all
	      elsif problem.due_date < DateTime.now.utc  #the due date is passed and they didn't submit, therefore they fail all missed cases
	        all += ProblemTestCase.where(problemid: problem.id).count
	      else # they havent submitted and the date is not passed so this doesn't affect their grade
	        success += submisson_suc
	        all += submisson_all
	      end
	    end
	    student.Problems_grade = success.to_s + "/" + all.to_s
	    student.save!
	end

end
