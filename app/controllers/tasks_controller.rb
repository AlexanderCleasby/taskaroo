require 'pry'
class TasksController < ApplicationController
    before_action :require_logged_in

    def create
        if !require_list_write_permissions
        
            task = Task.new(task_params)
            #binding.pry
            
            if task.save
              flash[:success] = "Task Added"
              redirect_to task.list
            else
              flash[:error] = "Task not added"
              redirect_to List.find(params[:task][:list_id])
            end
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

    def require_list_write_permissions
        if List.find(params[:id]).user_lists.where({privilege:"Add Tasks",user_id:session[:user_id]}) && List.find(params[:id]).owner_id != session[:user_id]
            redirect_to List.find(params[:task][:list_id])
        else
            false
        end
    end


end