class CourseProblemRelation < ActiveRecord::Base
  # Use this instead of create!.  This will automatically handle whether the course/problem exist
    def self.relate!(courseid, problemid)
        course = Course.find_by_id(courseid)
        problem = Problem.find_by_id(problemid)
        if not course.nil? and not problem.nil?
            @rel = self.create!({ :course => course.id, :problem => problem.id })
            @rel.save
            return @rel
        else
            return nil
        end
    end
    
# Could probably be DRYer, but meh
  # ANYTIME a problem is destroyed, call this also
    def self.destroy_by_problem(problemid)
        rels = CourseProblemRelation.where(:problem => problemid)
        rels.each do |rel|
            rel.destroy
        end
    end
    
  # ANYTIME a course is destroyed, call this also
    def self.destroy_by_course(courseid)
        rels = CourseProblemRelation.where(:course => courseid)
        rels.each do |rel|
            rel.destroy
        end
    end
end
