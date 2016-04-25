class QuizSubmission < ActiveRecord::Base
  def student
    Student.find_by_id(self.studentid)
  end
end
