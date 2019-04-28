class List < ApplicationRecord
    has_many :tasks 
    has_many :user_lists
    has_many :users, through: :user_lists
    accepts_nested_attributes_for :tasks

    def owner
        User.find(owner_id)
    end
end