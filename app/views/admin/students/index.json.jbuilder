json.array!(@students) do |student|
  json.extract! student, :id, :Name, :ID, :UserName, :Password, :Class
  json.url student_url(student, format: :json)
end
