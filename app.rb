require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("pg")

# DB = PG.connect({:dbname => "to_do"}) #connect to NON-TEST db

DB = PG.connect({:dbname => "to_do_test"}) # change back to above when done testing

get("/lists/:id") do # route to view a specific list
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:task_success)
end
