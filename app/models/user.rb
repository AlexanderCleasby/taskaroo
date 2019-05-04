class User < ApplicationRecord
    has_secure_password
    has_many :user_lists
    has_many :lists, through: :user_lists
    def shortname
        self.email.split('@').first
    end
end