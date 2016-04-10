json.array!(@submissions) do |submission|
  json.extract! submission, :id, :studentID, :problemID, :code, :timeOnPage, :response, :result
  json.url submission_url(submission, format: :json)
end
