require 'task'
require 'rspec'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'is initialized with a name and a list ID' do
    task = Task.new('learn SQL', 1)
    expect(task).to be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new('learn SQL', 1)
    expect(task.name).to eq 'learn SQL'
  end

  it 'tells you its list ID' do
    task = Task.new('learn SQL', 1)
    expect(task.list_id).to eq 1
  end

  it 'starts off with no tasks' do
    expect(Task.all).to eq []
  end

  it 'lets you save tasks to the database' do
    task = Task.new('learn SQL', 1)
    task.save
    expect(Task.all).to eq [task]
  end

  it 'is the same task if it has the same name and ID' do
    task1 = Task.new('learn SQL', 1)
    task2 = Task.new('learn SQL', 1)
    expect(task1).to eq task2
  end
end

