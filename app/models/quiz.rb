class Quiz < ActiveRecord::Base
    def course
        Course.find_by_id(self.courseid)
    end
end
