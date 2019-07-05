require 'pry'
class ListsController < ApplicationController
    before_action :require_logged_in, :confirm_list_exists, :require_list_permissions
    skip_before_action  :confirm_list_exists, :require_list_permissions, only: [:new, :create, :index]

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
        respond_to do |format|
            format.html { render :show }
            format.json { render json:@list}
        end
    end
    
    

    def index
        if params[:selector] == 'owned'
            @lists = List.owned(current_user)
        elsif params[:shared]
            @lists = List.can_be_written_by(current_user)
        end
        render json:@lists
        
    end

    private

    def lists_params
        params.require(:list).permit(:title)
    end
    
    

end