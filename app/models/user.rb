class User < ApplicationRecord
    has_secure_password

    def shortname
        self.email.split('@').first
    end
end