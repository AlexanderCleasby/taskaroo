require 'pry'
class ApplicationController < ActionController::Base

    private

    def require_logged_in        
        #binding.pry
        redirect_to controller: 'sessions', action: 'new' unless session[:user_id]
    end

    def require_list_permissions
        #binding.pry
        list = List.find_by(:id=>params[:id])
        redirect_to request.referer || root_path unless list.owner==current_user || list.users.include?(current_user)
    end

    def confirm_list_exists
        redirect_to controller: 'home', action: 'home' unless List.find_by(:id=>params[:id])
    end

    def current_user
        User.find_by(:id=>session[:user_id])
    end

    helper_method :current_user


end
