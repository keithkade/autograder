class Course < ActiveRecord::Base
    def problems
        tuples = CourseProblemRelation.where(:course => id)
        Problem.where(:id => tuples.map(&:problem))
    end

    def quizzes
        Quiz.where(:courseid => id)
    end

    def users
        tuples = CourseUserRelation.where(:course => id)
        Student.where(:id => tuples.map(&:user))
    end
    
  # alias using ruby convention
    def archived?
        self.is_archived
    end
    
    def self.unarchived
        Course.where(:is_archived => false)
    end
end
