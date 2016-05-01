json.array!(@quiz_submissions) do |quiz_submission|
  json.extract! quiz_submission, :id, :studentid, :quizid, :time_taken
  json.url quiz_submission_url(quiz_submission, format: :json)
end
