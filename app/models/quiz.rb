class Quiz < ActiveRecord::Base
  before_destroy :destroy_dependents
  
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
  
  def destroy_dependents
    QuizQuestion.where(:quizid => self.id).each { |q| q.destroy }
    QuizSubmission.where(:quizid => self.id).each { |q| q.destroy }
  end
end
