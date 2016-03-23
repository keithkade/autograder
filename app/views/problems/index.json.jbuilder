json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :body, :skeleton
  json.url problem_url(problem, format: :json)
end
