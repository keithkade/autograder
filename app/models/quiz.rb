class Quiz < ActiveRecord::Base
    def course
        Course.find_by_id(self.courseid)
    end
    
    def questions
        QuizQuestion.where(:quizid => self.id)
    end
end
