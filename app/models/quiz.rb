class Quiz < ActiveRecord::Base
  def course
    Course.find_by_id(self.courseid)
  end
  
  def questions
    QuizQuestion.where(:quizid => self.id)
  end
  
  def points_possible
    total = 0
    questions.each do |question|
      if not question.points.nil?
        total += question.points
      end
    end
    total
  end
end
