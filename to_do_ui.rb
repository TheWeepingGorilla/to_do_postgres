require 'pg'
require './lib/task'
require './lib/list'

DB = PG.connect({:dbname => 'to_do'})

def welcome
  puts "Welcome to the To Do list!"
  list_menu
end

def list_menu
  loop do
    puts " A > Add a list"
    puts " D > Delete a list"
    puts " V > View lists"
    puts " T > Add a task"
    puts " S > Show tasks"
    puts " X > Exit"
    puts "Please select an option from above:"
    choice = gets.chomp.upcase

    if choice == "A"
      add_list
    elsif choice == "D"
      delete_a_list
    elsif choice == "V"
      view_lists
    elsif choice == "T"
      add_task
    elsif choice == "S"
      show_tasks
    elsif choice == "X"
      exit
    else
      puts "Invalid input. Please try again."
    end
  end
end

def add_list
  puts "Please enter the name of the list:"
  name = gets.chomp.upcase
  new_list = List.new(name)
  new_list.save
  puts "List added!"
end

def delete_a_list
  view_lists
  puts "Select index of list to delete:"
  index = gets.chomp.to_i
  List.delete_list(index)
  puts "List deleted!"
end

def view_lists
  lists = List.all
  lists.each do |objects|
    puts objects.id.to_s + " " + objects.name
  end
end

def add_task
  view_lists
  puts "Select index of list to add task to:"
  index = gets.chomp.to_i
  puts "Enter task name"
  task_name = gets.chomp
  new_task = Task.new(task_name,index)
  new_task.save
end

def show_tasks
  tasks = Task.all
  tasks.each do |objects|
    puts objects.list_id.to_s + " " + objects.name
  end
end

welcome
