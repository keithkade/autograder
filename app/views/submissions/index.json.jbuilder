json.array!(@submissions) do |submission|
  json.extract! submission, :id, :studentID, :problemID, :code, :timeOnPage, :response
  json.url submission_url(submission, format: :json)
end
