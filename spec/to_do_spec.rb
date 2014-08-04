require 'task'
require 'rspec'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  it 'is initialized with a name' do
    task = Task.new('learn SQL')
    expect(task).to be_an_instance_of Task
  end

  it 'tells you its name' do
    task = Task.new('learn SQL')
    expect(task.name).to eq 'learn SQL'
  end
end

describe Task do
  it 'starts off with no tasks' do
    expect(Task.all).to eq []
  end
end

describe Task do
  it 'lets you save tasks to the database' do
    task = Task.new('learn SQL')
    task.save
    expect(Task.all).to eq [task]
  end
end

describe Task do
  it 'is the same task if it has the same name' do
    task1 = Task.new('learn SQL')
    task2 = Task.new('learn SQL')
    expect(task1).to eq task2
  end
end

