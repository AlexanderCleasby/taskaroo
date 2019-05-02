require 'pry'
class TasksController < ApplicationController

    def toggleCompleted
        @task=Task.find_by(params[:id])
        if @task
            @task.update({completed:!@task.completed})
        end
        redirect_to controller:"lists",action: "show", id: @task.list.id
    end

    private

    def task_params
        params.require(:list).permit(:completed)
    end


end