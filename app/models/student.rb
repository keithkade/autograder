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

    def quiz_submissions
    	q_submissions = QuizSubmission.where(:studentid => self.id)
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

    def quizs_grade
    	grade = ""
    	quiz_submissions = self.quiz_submissions
    	total_grade = 0
    	possible_points = 0
    	for submisson in quiz_submissions
    		if submisson.graded?
    			total_grade += submisson.points
    			possible_points += submisson.quiz.points_possible
    		else
    			if submisson.quiz.end_time < DateTime.now
    				possible_points += submisson.quiz.points_possible
    			end
    		end
    	end
    	if possible_points != 0 
    		grade = (100 * total_grade/possible_points).to_s + "%"
    	else
    		grade = "No Quizzes"
    	end
    	student = Student.find(self.id)
    	student.Quizs_grade = grade
    	student.save!
    end

	def problems_grade
	    student = Student.find(self.id)
	    problems = student.problems
	    success = 0
	    all = 0
	    late_success = 0
	    late_all = 0
	    for problem in problems
			submissons = Submission.where(:problem_id => problem.id).where(:student_id => self.id)
			submisson_suc = 0
			submisson_all = 0
			#finds ontime completed submissions and stores the grade of the best
			for submisson in submissons
				if submisson.complete == true
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
			end
			if submisson_all != 0  #there is at least one completed submissions
				success += submisson_suc
				all += submisson_all
			elsif problem.due_date < DateTime.now #the due date is passed and they didn't submit on time
				for submisson in submissons
					if submisson.complete == true
						if submisson.total_cases > 0
							if submisson_suc < submisson.success_cases
								submisson_suc = submisson.success_cases
							end
						end
					end
				end
				late_success += submisson_suc
				late_all += ProblemTestCase.where(problemid: problem.id).count
			else # they havent submitted and the date is not passed so this doesn't affect their grade
				success += submisson_suc
				all += submisson_all
			end

		end
		student.lateProblemsGrade = late_success.to_s + "/" + late_all.to_s
	    student.Problems_grade = success.to_s + "/" + all.to_s
	    student.save!
	end

	def incomplete_problems_past_due
		student = Student.find(self.id)
		problems = student.problems
		missing_problems = []
		for problem in problems
			if problem.due_date < DateTime.now
				problem_is_missing = true
				submissons = Submission.where(:problem_id => problem.id).where(:student_id => self.id)
				for submisson in submissons
					if submisson.complete == true
						problem_is_missing = false
					end
				end
				if problem_is_missing == true
					missing_problems.push(problem)
				end
			end
		end
		return missing_problems
	end

end
