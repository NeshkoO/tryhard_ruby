require_relative 'task_manager'

def is_number? string
  true if Float(string) rescue false
end

puts 'Welcome to the TaskList program!'
task_manager = TaskManager.new

while true
  puts "Menu: (1) - add task, (2) - set task complete, (3) - delete task, (4) - show all tasks list,\
 (5) - show completed task, (6) - show actual tasks, else - quit ."
  value = gets.chomp.to_i
  puts case value
         when 1
           puts 'Enter the text of task'
           text = gets.chomp
           task_manager.add_task({:text => text})

         when 2
           puts 'Enter the number of task to set completed'
           number_of_task = gets.chomp
           if is_number? number_of_task
             task_manager.set_task_complete number_of_task.to_i
           else
             'Entered value is not a number'
           end

         when 3
           puts 'Enter the number of task to delete'
           number_of_task = gets.chomp
           if is_number? number_of_task
             task_manager.delete_task number_of_task.to_i
           else
             'Entered value is not a number'
           end

         when 4
           puts task_manager.get_tasks_list
         when 5
           puts task_manager.get_tasks_list 'completed'
         when 6
           puts task_manager.get_tasks_list 'actual'
         else
           'No such parameter in menu, so quit.'
           break
       end
end
