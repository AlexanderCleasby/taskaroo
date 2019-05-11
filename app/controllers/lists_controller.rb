require 'pry'
class ListsController < ApplicationController
    before_action :require_logged_in, :confirm_list_exists, :require_list_permissions
    skip_before_action  :confirm_list_exists, :require_list_permissions, only: [:new, :create]

    def new
        @list=List.new
    end

    def create
        
        @list = List.new(lists_params)
        @list.owner_id = session[:user_id]
        #binding.pry
        if @list.save
          redirect_to @list
        else
          render 'new'
        end
    end

    def show
        @list = List.find(params[:id])
    end
    
    

    def index
        @list = List.all
    end

    private

    def lists_params
        params.require(:list).permit(:title)
    end
    
    

end