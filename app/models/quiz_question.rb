class QuizQuestion < ActiveRecord::Base
    
    def question
        case self.qtype
        when 'multiple_choice'
            QuizMultipleChoiceQuestion.find_by_id(self.qid)
        when 'free_response'
            QuizFreeResponseQuestion.find_by_id(self.qid)
        else
            nil
        end
    end
    
    def take_question_layout
        "admin/quiz_#{self.qtype}_questions/take"
    end
    
    def answer_layout
        "admin/quiz_#{self.qtype}_questions/answer"
    end
    
    def submission_layout
        "admin/quiz_#{self.qtype}_questions/submission"
    end
    
    def self.question_types
        ["multiple_choice", "free_response"]
    end
end
