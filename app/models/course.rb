class Course < ActiveRecord::Base
    def problems
        tuples = CourseProblemRelation.where(:course => id)
        Problem.where(:id => tuples.map(&:problem))
    end
    
    def users
        tuples = CourseUserRelation.where(:user => id)
        Student.where(:id => tuples.map(&:user))
    end
end
