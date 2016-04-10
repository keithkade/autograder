json.array!(@course_problem_relations) do |course_problem_relation|
  json.extract! course_problem_relation, :id, :course, :problem
  json.url course_problem_relation_url(course_problem_relation, format: :json)
end
