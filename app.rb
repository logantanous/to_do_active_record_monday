require("sinatra/activerecord")
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("pg")
require("pry")

get('/') do
  @tasks = Task.all
  erb(:index)
end

post('/') do
  task = params[:task]
  new_task = Task.new(:description => task)
  new_task.save
  @tasks = Task.all
  erb(:index)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch("id").to_i())
  erb(:task_edit)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end
