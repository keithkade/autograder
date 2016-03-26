json.array!(@problems) do |problem|
  json.extract! problem, :id, :title, :summary, :input_description, :output_description, :skeleton
  json.url problem_url(problem, format: :json)
end
