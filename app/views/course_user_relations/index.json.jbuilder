json.array!(@course_user_relations) do |course_user_relation|
  json.extract! course_user_relation, :id, :course, :user
  json.url course_user_relation_url(course_user_relation, format: :json)
end
