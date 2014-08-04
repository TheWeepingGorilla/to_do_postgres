require 'pg'

class List
  attr_accessor :name, :id

  def initialize (name,id = nil)
    @name = name
    @id = id
  end

  def ==(another_list)
    self.name == another_list.name && self.id == another_list.id
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      lists << List.new(name,id)
    end
    lists
  end

  def save
    results = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end
end
