require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) {
    { title: 'Test Task', description: 'This is a test task', status: 'In Progress' }
  }

  let(:invalid_attributes) {
    { title: nil, description: 'This is a test task', status: 'To Do' }
  }

  before(:each) do
    3.times { Task.create!(title: "Existing Task", description: "This is an existing task", status: "To Do") }
    3.times { Task.create!(title: "Existing Task", description: "This is an existing task", status: "In Progress") }
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new Task' do
        expect {
          post :create, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it 'redirects to the tasks list' do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Task' do
        expect {
          post :create, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it 'returns a success response (i.e., to display the "new" template)' do
        post :create, params: { task: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
