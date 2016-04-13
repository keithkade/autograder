class Student < ActiveRecord::Base
    def courses
        tuples = CourseUserRelation.where(:user => id)
        Course.where(:id => tuples.map(&:course))
    end
    
    def Name
        self.FirstName + " " + self.LastName
    end
end
