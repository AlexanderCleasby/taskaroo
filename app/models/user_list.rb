class UserList < ApplicationRecord
    belongs_to :list
    belongs_to :user

    validates :user, presence: { message: "an email for a valid user needs to be given" }
end