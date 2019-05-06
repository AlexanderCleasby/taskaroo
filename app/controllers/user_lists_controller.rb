require 'pry'
class UserListsController < ApplicationController
    def new
        @user_list = UserList.new
        @user_list.list = List.find_by(:id=>params[:id])
    end
    
    def create
        @user_list = UserList.new(user_lists_params)
        @user_list.user = User.find_by(:email=>params[:email])
        @user_list.list = List.find_by(:id=>params[:id])
        @user_list.save
        
        redirect_to @user_list.list
    end


    private

    def user_lists_params
        params.require(:user_list).permit(:user_id,:list_id,:privilege)
    end

end