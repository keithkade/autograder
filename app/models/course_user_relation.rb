class CourseUserRelation < ActiveRecord::Base
  # Use this instead of create!.  This will automatically handle whether the course/user exist
    def self.relate!(courseid, userid)
        course = Course.find_by_id(courseid)
        user = Student.find_by_id(userid)
        if not course.nil? and not user.nil?
            @rel = self.create!({ :course => course.id, :user => user.id })
            @rel.save
            return @rel
        else
            return nil
        end
    end
    
# Could probably be DRYer, but meh
  # ANYTIME a user is destroyed, call this also
    def self.destroy_by_user(userid)
        rels = CourseUserRelation.where(:user => userid)
        rels.each do |rel|
            rel.destroy
        end
    end
    
  # ANYTIME a course is destroyed, call this also
    def self.destroy_by_course(courseid)
        rels = CourseUserRelation.where(:course => courseid)
        rels.each do |rel|
            rel.destroy
        end
    end
end
