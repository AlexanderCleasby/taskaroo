class HomeController < ApplicationController
    before_action :require_logged_in

def home
    @owned_lists = List.owned(current_user)
    @shared_lists = List.can_be_written_by(current_user)
end

end