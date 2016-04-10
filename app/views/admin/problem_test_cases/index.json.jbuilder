json.array!(@problem_test_cases) do |problem_test_case|
  json.extract! problem_test_case, :id, :problemid, :input, :output
  json.url problem_test_case_url(problem_test_case, format: :json)
end
