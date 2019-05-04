require 'pry'
class ListsController < ApplicationController
    before_action :require_logged_in
    
    def new
        @list=List.new
    end

    def create
        
        @list = List.new(lists_params)
        @list.owner_id = session[:user_id]
        #binding.pry
        if @list.save
          flash[:success] = "Object successfully created"
          redirect_to @list
        else
          flash[:error] = "Something went wrong"
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