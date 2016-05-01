json.array!(@quiz_multiple_choice_questions) do |quiz_multiple_choice_question|
  json.extract! quiz_multiple_choice_question, :id, :question, :answers, :correct_answer
  json.url quiz_multiple_choice_question_url(quiz_multiple_choice_question, format: :json)
end
