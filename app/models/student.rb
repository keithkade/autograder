class Student < ActiveRecord::Base
    require 'pp'

    def courses
        tuples = CourseUserRelation.where(:user => id)
        Course.where(:id => tuples.map(&:course))
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

    def Name
        self.FirstName + " " + self.LastName
    end
end
