require_relative 'task'
class TaskManager

  def initialize
    @tasks = []
  end

  def add_task options
    @tasks.push(Task.new({:text => options[:text]}))
    'The task has been added'
  end

  def set_task_complete(number)
    if @tasks.fetch(number, nil).nil?
      "Sorry, no task exists with this number #{number}"
    else
      @tasks.at(number).active = false
      "Task with number #{number} successfully updated."
    end
  end

  def delete_task(number)
    @tasks.delete_at(number).nil? ? "Sorry, no task with this number #{number}" : \
    "Task with number #{number} successfully deleted."
  end

  def get_tasks_list status = 'all'
    result = 'Available task list:'
    case status
      when 'actual'
        @tasks.each { |task|
          result= "#{result}\n \t Id:#{task.id}  Text: \"#{task.text}\"  Active: #{task.active}" if task.active
        }
      when 'completed'
        @tasks.each { |task|
          result= "#{result}\n \t Id:#{task.id}  Text: \"#{task.text}\"  Active: #{task.active}" unless task.active
        }
      else
        @tasks.each { |task|
          result= "#{result}\n \t Id:#{task.id}  Text: \"#{task.text}\"  Active: #{task.active}"
        }
    end
    result
  end
end