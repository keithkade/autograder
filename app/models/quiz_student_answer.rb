class QuizStudentAnswer < ActiveRecord::Base
  def question
    QuizQuestion.find_by_id(self.questionid)
  end
  
  def graded?
    not self.points.nil?
  end
  
  def correct?
    self.points == question.points
  end
  
  def partial?
    self.points < question.points and self.points > 0
  end
  
  def incorrect?
    self.points == 0
  end
  
# View stuff
  def status_css_class
    if graded?
      if correct?
        'success'
      elsif partial?
        'warning'
      else
        'danger'
      end
    else
      'info'
    end
  end
  
  def raw_score
    "#{self.points} / #{question.points}"
  end
end
