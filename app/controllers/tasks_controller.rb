require 'pry'
class TasksController < ApplicationController
    before_action :require_logged_in

    def create
        #binding.pry
        task = Task.new(task_params)
        #binding.pry
        
        if task.save
          flash[:success] = "Object successfully created"
          redirect_to task.list
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end
    
    

    def toggleCompleted
        @task=Task.find_by({id:params[:id]})
        #binding.pry
        if @task
            @task.update({completed:!@task.completed})
        end
        redirect_to controller:"lists",action: "show", id: @task.list.id
    end

    private

    def task_params
        params.require(:task).permit(:completed,:title,:list_id)
    end


end