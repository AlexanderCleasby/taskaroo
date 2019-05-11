class List < ApplicationRecord
    has_many :tasks 
    has_many :user_lists
    has_many :users, through: :user_lists
    accepts_nested_attributes_for :tasks

    def owner
        User.find(owner_id)
    end

    def canwrite(id)
        if self.owner_id==id
            return true
        elseif self.user_lists.find_by({user_id:id})
            return self.user_lists.find_by({user_id:id}).privilege
        else
            false
        end
    end

end