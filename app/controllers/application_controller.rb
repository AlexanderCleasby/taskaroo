require 'pry'
class ApplicationController < ActionController::Base

    private

    def require_logged_in
        redirect_to controller: 'sessions', action: 'new' unless session[:user_id]
    end

end
