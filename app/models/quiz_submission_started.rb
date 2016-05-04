class QuizSubmissionStarted < ActiveRecord::Base
# Return true if the quiz has already been started
  def self.started?(quizid, studentid)
    QuizSubmissionStarted.where(:quizid => quizid).where(:studentid => studentid).length > 0
  end
end
