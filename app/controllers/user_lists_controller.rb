require 'pry'
class UserListsController < ApplicationController
    def new
        @user_list = UserList.new
        @user_list.list = List.find_by(:id=>params[:id])
    end
    
    def create
        @user_list = UserList.new()
        @user_list.privilege = params[:privilege]
        @user_list.user = User.find_by(:email=>params[:email])
        @user_list.list = List.find_by(:id=>params[:id])
        if @user_list.save
            redirect_to @user_list.list
        else
            render 'new'
        end
    end


    private

    def user_lists_params
        params.require(:user_list).permit(:user_id,:list_id,:privilege)
    end

end