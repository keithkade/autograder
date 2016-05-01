json.array!(@quiz_free_response_questions) do |quiz_free_response_question|
  json.extract! quiz_free_response_question, :id, :correct_answer, :question
  json.url quiz_free_response_question_url(quiz_free_response_question, format: :json)
end
