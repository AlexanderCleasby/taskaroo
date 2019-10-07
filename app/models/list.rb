
class List < ApplicationRecord
    has_many :tasks 
    has_many :user_lists
    has_many :users, through: :user_lists
    accepts_nested_attributes_for :tasks

    def self.owned(user)
        List.where(:owner_id=>user.id)
    end

    def self.can_be_written_by(user)       
        user.lists.joins(:user_lists).where(user_lists:{privilege:"Add Tasks"})
    end

    def self.writeable
        self.joins(:user_lists).where(user_lists:{privilege:"Add Tasks"})
    end

    def owner
        User.find(owner_id)
    end

    def can_be_written_by(user)
        List.can_be_written_by(user).include?(self) || self.owner_id==user.id
        
    end

    def completion
        self.tasks.select {|task| task.completed }.count.to_s+"/"+self.tasks.count.to_s
    end

end