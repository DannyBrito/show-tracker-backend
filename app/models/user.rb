class User < ApplicationRecord
    has_many :tvshows
    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    def get_attributes
        remove_ts(self.attributes)
    end
    
    private

    def remove_ts(hash)
        hash.reject{|key,v| key == 'password_digest' ||key == "created_at" || key == "updated_at"}
    end
end
