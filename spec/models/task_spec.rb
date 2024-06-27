require 'rails_helper'

RSpec.describe Task, type: :model do
  before(:each) do
    # Create initial tasks to check the custom validation
    3.times { Task.create!(title: "Existing Task", description: "This is an existing task", status: "To Do") }
    3.times { Task.create!(title: "Existing Task", description: "This is an existing task", status: "In Progress") }
  end

  it 'is valid with valid attributes' do
    task = Task.new(title: 'Test Task', description: 'This is a test task', status: 'In Progress')
    expect(task).to be_valid
  end

  it 'is not valid without a title' do
    task = Task.new(description: 'This is a test task', status: 'To Do')
    expect(task).not_to be_valid
  end

  it 'is not valid without a status' do
    task = Task.new(title: 'Test Task', description: 'This is a test task')
    expect(task).not_to be_valid
  end

  it 'is not valid with a duplicate title' do
    Task.create!(title: 'Test Task', description: 'This is a test task', status: 'In Progress')
    task = Task.new(title: 'Test Task', description: 'This is another test task', status: 'In Progress')
    expect(task).not_to be_valid
  end

  it 'cannot create more "To Do" tasks if they exceed 50% of total tasks' do
    task = Task.new(title: 'Another Task', description: 'This task should not be created', status: 'To Do')
    expect(task).not_to be_valid
    expect(task.errors[:base]).to include("Cannot create more 'To Do' tasks as it exceeds 50% of total tasks.")
  end
end
