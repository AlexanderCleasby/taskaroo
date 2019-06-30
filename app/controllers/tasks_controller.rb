require 'pry'
class TasksController < ApplicationController
    before_action :require_logged_in
    before_action :require_list_permissions, only: :toggle
    before_action :require_list_write_permissions, only: [:create,:update]
    skip_before_action :verify_authenticity_token, only: :toggleCompleted
    def create
        
        
        task = Task.new(task_params)
        #binding.pry
        
        if task.save
        
          redirect_to task.list
        else
          
          redirect_to List.find(params[:task][:list_id])
        end
        
    end
    
    def update
        @task = Task.find(params[:id])
        flash[:error] = "Task failed to update" unless @task.update_attributes(task_params)
        redirect_to @task.list
    end
        

    def toggleCompleted
        
        @task=Task.find_by({id:params[:id]})
        #binding.pry
        if @task
            @task.update({completed:!@task.completed})
        end
        render :json => @task
        #redirect_to controller:"lists",action: "show", id: @task.list.id
    end

    private

    def task_params
        params.require(:task).permit(:completed,:title,:list_id)
    end

    def require_list_write_permissions
        if !List.find_by({id:params[:id]}).can_be_written_by(current_user)

            flash[:error] = "that isn't allowed!"
            redirect_to List.find_by({id:params[:id]})
        end
        #if List.find(params[:id]).user_lists.where({privilege:"Add Tasks",user_id:session[:user_id]}) && List.find(params[:id]).owner_id != session[:user_id]
        #    redirect_to List.find(params[:task][:list_id])
        #else
        #    false
        #end
    end


end