class HomeController < ApplicationController

def home
    @owned_lists = List.where(:owner_id=>session[:user_id])
    @shared_lists = User.find(session[:user_id]).lists
end

end