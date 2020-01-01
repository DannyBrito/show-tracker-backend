class User < ApplicationRecord

    has_one :watchlist, dependent: :destroy 
    after_create :build_watchlist

    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    
        def get_attributes
            remove_ts(self.attributes)
        end

    private

    #create a watchlist along user being created
    def build_watchlist
        Watchlist.create(user: self)
        true
    end

    def remove_ts(hash)
        hash.reject{|key,v| key == 'password_digest' ||key == "created_at" || key == "updated_at"}
    end
end
