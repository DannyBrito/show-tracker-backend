class User < ApplicationRecord

    has_one :watchlist, dependent: :destroy 
    after_create :build_watchlist

    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }

    private

    #create a watchlist along user being created
    def build_watchlist
        Watchlist.create(user: self)
        true
    end
end
