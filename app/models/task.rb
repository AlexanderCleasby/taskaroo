class Task < ApplicationRecord
    belongs_to :list
    #belongs_to :user

    default_scope {order(completed: :desc,updated_at: :asc)}
end