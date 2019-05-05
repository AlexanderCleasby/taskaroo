require 'pry'
class ApplicationController < ActionController::Base

    private

    def require_logged_in        
        #binding.pry
        redirect_to controller: 'sessions', action: 'new' unless session[:user_id]
    end

    def require_list_permissions
        redirect_to controller: 'home', action: 'home' unless List.find_by(:id=>params[:id]).owner==User.find_by(:id=>session[:user_id]) 
    end

    def confirm_list_exists
        redirect_to controller: 'home', action: 'home' unless List.find_by(:id=>params[:id])
    end

end
