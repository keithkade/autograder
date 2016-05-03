class Problem < ActiveRecord::Base
    before_destroy :destroy_dependents
    
    def courses
        tuples = CourseProblemRelation.where(:problem => id)
        Course.where(:id => tuples.map(&:course))
    end
    
    def self.languages
        ['java', 'python']
    end
    
private
    def destroy_dependents
        CourseProblemRelation.destroy_by_problem(self.id)
        ProblemTestCase.where(:problemid => self.id).each { |ptc| ptc.destroy }
        Submission.where(:problem_id => self.id).each { |s| s.destroy }
    end
end
