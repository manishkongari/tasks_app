# app/models/task.rb
class Task < ApplicationRecord
    # Validations
    validates :title, presence: true
    validates :status, inclusion: { in: %w(To\ Do In\ Progress Done),
                                    message: "%{value} is not a valid status" }
    validate :validate_todo_limit, if: -> { status == 'To Do' }
  
  
    private
  
    def validate_todo_limit
      # Count total tasks
      total_tasks_count = Task.count
  
      # Count "To Do" tasks
      todo_tasks_count = Task.where(status: 'To Do').count
  
      # Check if adding a new "To Do" task exceeds the 50% limit
      if (todo_tasks_count + 1) > (total_tasks_count / 2)
        errors.add(:base, "Cannot create more 'To Do' tasks as it exceeds 50% of total tasks.")
      end
    end
  end
  