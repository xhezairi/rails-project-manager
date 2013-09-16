json.array!(@tasks) do |task|
  json.extract! task, :name, :description, :difficulty_level, :project_id
  json.url task_url(task, format: :json)
end
