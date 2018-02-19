class Task
  attr_reader(:description)

  def initialize(attributes)
    @description = attributes[:description]
  end

  def ==(another_task)
    self.description().==(another_task.description())
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;") # gem .exec method to select all tasks (i.e. columns)
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description") #???
      tasks.push(Task.new({:description => description}))
    end # converting SQL db to Ruby code so app can understand it
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (description) VALUES ('#{@description}');")
  end
end
