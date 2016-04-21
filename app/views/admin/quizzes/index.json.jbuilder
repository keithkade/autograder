json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :start_time, :end_time, :time_limit, :questions
  json.url quiz_url(quiz, format: :json)
end
