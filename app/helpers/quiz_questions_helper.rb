module QuizQuestionsHelper
  def new_quiz_question_of_type_path(type, parameters = {})
      path = "/admin/quiz_#{type}_questions/new"
      parameters.each_with_index do |(key, value), i|
          path += i == 0 ? "?" : "&"
          path += key.to_s + "=" + value.to_s
      end
      return path
  end
  
  def edit_quiz_question_of_type_path(type, question, parameters = {})
      path = "/admin/quiz_#{type}_questions/#{question.id}/edit"
      parameters.each_with_index do |(key, value), i|
          path += i == 0 ? "?" : "&"
          path += key.to_s + "=" + value.to_s
      end
      return path
  end
  
# question is a QuizQuestion
  def quiz_question_of_type_path(type, question)
      "/admin/quiz_#{type}_questions/#{question.id}"
  end
end
