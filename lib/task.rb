class Task
  attr_reader(:description, :list_id) # added to task the id from list

  def initialize(attributes)
    @description = attributes[:description]
    @list_id = attributes[:list_id]
  end

  def ==(another_task)
    self.description().==(another_task.description())
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;") # gem .exec method to select all tasks (i.e. columns)
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      # creates a list id task belongs to
      # The information comes out of the database as a string.
      tasks.push(Task.new({:description => description, :list_id => list_id}))
    end # converting SQL db to Ruby code so app can understand it
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});") #@list_id added in
  end
  #in the save method, we didn't include ' ' around the #{} string interpolation of @list_id because we want the list_id attribute to go into the database as a number.

  def ==(another_task)
   self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end
end
