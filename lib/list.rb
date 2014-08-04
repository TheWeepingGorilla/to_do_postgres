require 'pg'

class List
  attr_accessor :name

  def initialize (name)
    @name = name
  end

  def ==(another_task)
    self.name == another_task.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      lists << List.new(name)
    end
    lists
  end

  def save
    DB.exec("INSERT INTO lists (name) VALUES ('#{@name}');")
  end
end
